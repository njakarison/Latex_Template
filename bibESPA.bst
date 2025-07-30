
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN
%% archives in directory macros/latex/base/lppl.txt; either
%% version 1 of the License, or any later version.
%%
 % Version and source file information:
 % \ProvidesFile{natbst.mbs}[2007/11/26 1.93 (PWD)]
 %
 % BibTeX `plainnat' family
 %   version 0.99b for BibTeX versions 0.99a or later,
 %   for LaTeX versions 2.09 and 2e.
 %
 % For use with the `natbib.sty' package; emulates the corresponding
 %   member of the `plain' family, but with author-year citations.
 %
 % With version 6.0 of `natbib.sty', it may also be used for numerical
 %   citations, while retaining the commands \citeauthor, \citefullauthor,
 %   and \citeyear to print the corresponding information.
 %
 % For version 7.0 of `natbib.sty', the KEY field replaces missing
 %   authors/editors, and the date is left blank in \bibitem.
 %
 % Includes field EID for the sequence/citation number of electronic journals
 %  which is used instead of page numbers.
 %
 % Includes fields ISBN and ISSN.
 %
 % Includes field URL for Internet addresses.
 %
 % Includes field DOI for Digital Object Idenfifiers.
 %
 % Works best with the url.sty package of Donald Arseneau.
 %
 % Works with identical authors and year are further sorted by
 %   citation key, to preserve any natural sequence.
 %
ENTRY
  { address
    author
    booktitle
    chapter
    day
    doi
    eid
    edition
    editor
    howpublished
    institution
    isbn
    issn
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    volume
    version
    year
  }
  {}
  { label extra.label sort.label short.list }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS {z s t }
 
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.null}
{ duplicate$ empty$
    {'pop$}
    {'s := "" * write$ 
	  s}
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}


FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}


FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "\emph{" swap$ * "}" * }
  if$
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { 
      nameptr #1 >
      { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't := }
      { s nameptr "{vv~}{ll}{, j}{, ff}" format.name$ 't := }
      if$
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { numnames #2 >
                { "" * }
                'skip$
              if$
              t "others" =
                { " et~al." * }
                { "~\&~" * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.full.names}
{'s :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    {
      s nameptr "{vv~}{ll}{,jj}{, f.}" format.name$ 't := 
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { 
              t "others" =
                { " et~al." * }
                { "~\&~" * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}


FUNCTION {format.key}
{ empty$
    { key field.or.null }
    { "" }
  if$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors.full}
{ editor empty$
    { "" }
    { editor format.full.names
      editor num.names$ #1 >
        { " (\bibEd s.)" * }
        { " (\bibEd .)" * }
      if$
    }
  if$
}

FUNCTION {author.full}
{ author empty$
    { "" }
    { author format.full.names }
  if$
}

FUNCTION {editor.full}
{ editor empty$
    { "" }
    { format.editors.full }
  if$
}

FUNCTION {author.editor.full}
{ author empty$
    { editor empty$
        { "" }
        { editor format.full.names }
      if$
    }
    { author format.full.names }
  if$
}

FUNCTION {make.full.names}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.full
    { type$ "proceedings" =
        'editor.full
        'author.full
      if$
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  ")" make.full.names duplicate$ short.list =
     { pop$ }
     { * }
   if$
  "]{" * write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {format.year}
{ year duplicate$ empty$
    { "empty year in " cite$ * warning$
       pop$ "" }
    'skip$
  if$
  extra.label *
}

FUNCTION {format.year.par}
{ year empty$
    { "empty year in " cite$ * warning$ ""}
    { "(" year *  extra.label * ")" * }
  if$
}

FUNCTION {format.year.month.par}
{ year empty$
    { "empty year in " cite$ * warning$}
    { month empty$
    	{ "(" year *  extra.label * ")" * }
    	{ "(" year *  extra.label * ",~" * month * ")" * }
    	if$}
  if$
}

FUNCTION {format.year.month.day.par}
{ year empty$
    { "empty year in " cite$ * warning$}
    { month empty$
    	{ "(" year *  extra.label * ")" * }
    	{ day empty$
    		{ "(" year *  extra.label * ",~" * month * ")" * }
    	    { "(" year *  extra.label * ",~" * month * ",~" * day * ")" * }
			if$ }
    	if$}
  if$
}


FUNCTION {format.title}
{ title empty$
    { "" }
    {title "t" change.case$}
  if$
}

FUNCTION {format.journal}
{ journal empty$
    { "" }
    {journal "t" change.case$}
  if$
}

FUNCTION {format.booktitle}
{ booktitle empty$
    { "" }
    {booktitle "t" change.case$}
  if$
}

FUNCTION {format.edition.par}
{ edition empty$
    { "" }
    { "(\bibed." tie.or.space.connect edition ")" * }
  if$
}

FUNCTION {format.version}
{ version empty$
    { "" }
    { "[" version "]" * *}
  if$
}

FUNCTION {format.version.par}
{ version empty$
    { "" }
    { "(Version" tie.or.space.connect version ")" * }
  if$
}

%% Priority to doi
FUNCTION {format.doi.or.url}
{ doi empty$
	{ url empty$
		{""}
	 	{ "\biburlrep~\url{" url * "}" * }
	 if$ }
	{ "doi:~\detokenize{" doi * "}" *}
if$
}

%% Priority to note
FUNCTION {format.note.or.url}
{ note empty$
	{ url empty$
		{""}
	 	{ "\biburlrep~\url{" url * "}" * }
	 if$ }
	{ "\biburlrep~" note * }
if$
}

FUNCTION {format.url}
{ url empty$
	{""}
	{ "\biburlrep~\url{" url * "}" * }
if$ 
}

FUNCTION {format.addr.publish}
{ address empty$
    { publisher empty$
        {""}
        { " " publisher * }
      if$
    }
    { publisher empty$
    	 { organization empty$
        	{ " " address * }
        	{ " " address * ": " * organization * }
        	if$}
        { " " address * ": " * publisher * }
      if$
    }
  if$
}

FUNCTION {format.addr.organization}
{ address empty$
    { organization empty$
        {""}
        { " " organization * }
      if$
    }
    { organization empty$
        { " " address * }
        { " " address * ": " * organization * }
      if$
    }
  if$
}

FUNCTION {format.booktitle.editor}
{ booktitle empty$
	{ "empty booktitle in " cite$ * warning$}
	{ editor empty$
		{ "\bibin~"  booktitle emphasize *}
		{ "\bibin~" editor.full * ",~" *  booktitle emphasize *}
	if$ }
if$
}

FUNCTION {format.edition.vol.pages.par}
{ edition empty$ volume empty$ pages empty$ and and 
    { "" }
    { "("
     edition empty$
     	'skip$
     	{ "\bibed.~" *  edition *}
     if$
     volume empty$
     	'skip$
     	{ edition empty$
     		'skip$
     		{",~" *}
     	if$
     	"vol.~" * volume * }
     if$
     pages empty$
     	'skip$
     	{ edition empty$ volume empty$ and
     		'skip$
     		{",~" *}
     	if$
     	"pp.~"  * pages * }
     if$
     ")" *
     }
  if$
}

FUNCTION {format.edition.vol.chap.pages.par}
{ 	edition empty$ volume empty$ chapter empty$ pages empty$ and and and 
    { "" }
    { "("
     edition empty$
     	'skip$
     	{ "\bibed.~" *  edition *}
     if$
     volume empty$
     	'skip$
     	{ edition empty$
     		'skip$
     		{",~" *}
     	if$
     	"vol.~" * volume * }
     if$
     chapter empty$
     	'skip$
     	{ edition empty$ volume empty$ and
     		'skip$
     		{",~" *}
     	if$
     	"ch.~"  * chapter * }
     if$
     pages empty$
     	'skip$
     	{ edition empty$ volume empty$ chapter empty$ and and
     		'skip$
     		{",~" *}
     	if$
     	"pp.~"  * pages * }
     if$
     ")" *
     }
  if$
}  

FUNCTION {format.vol.number}
{ volume empty$
	{ number empty$
		{""}
		{"(" number * ")" *}
	if$ }
	{ number empty$
		{volume}
		{volume "(" * number ")" * *}
	if$ }
if$ 
}

FUNCTION {format.vol.number.or.series}
{ volume empty$
	{ number empty$ series empty$ and
		{""}
		{ number empty$
		    {"(" series * ")" *}
		    {"(" number * ")" *}
		    if$ }
	if$ }
	{  number empty$ series empty$ and
		{volume}
		{ number empty$
		    {volume "(" * series ")" * *}
		    {volume "(" * number ")" * *}
		    if$ }
	if$ }
if$ 
}

FUNCTION {format.proceedings.type}
{ type empty$
	 {""}
	 {type "~\bibpres~" * }
if$
}

FUNCTION {format.pages}
{ pages empty$
	 {""}
	 {"pp.~" pages *  }
if$
}

FUNCTION {format.pages.par}
{ pages empty$
	 {""}
	 {"(pp.~" * pages ")" *  }
if$
}

FUNCTION {format.master.school.address}
{ type empty$
	{"(\bibmaster"}
	{"(" type * }
if$
school empty$
	'skip$
	{",~" * school *}
if$
address empty$
	 {")" *}
	 {",~" * address * ")" *}
if$
}

FUNCTION {format.phd.school.address}
{ type empty$
	{"(\bibphd"}
	{"(" type * }
if$
school empty$
	'skip$
	{",~" * school *}
if$
address empty$
	 {")" *}
	 {",~" * address * ")" *}
if$
}

FUNCTION {format.rap.number.par}
{ number empty$
		{""}
		{"(\bibrap~ n$^{\circ}$" number * ")" *}
	if$
}
 
 FUNCTION {format.patent.type.number}
{ type empty$
		{"empty type in " cite$ * warning$}
		{ number empty$
			{type *}
			{type "~n$^{\circ}$" * number *}
		if$}		
	if$
}

FUNCTION {format.type.bra}
{ type empty$
	{""}
	{"[" type * "]" *}
if$
}
 
FUNCTION {format.note.bra}
{ note empty$
	{""}
	{"[" note * "]" *}
if$
}

FUNCTION {article}
{ output.bibitem
	author.full output
  	author format.key output
  	new.block
  	format.year.par output
  	new.block
	format.title output
	new.block
	format.journal emphasize output
	format.vol.number output
	pages "pages" output.check
	new.block
  	format.doi.or.url output
  	new.block
  	note empty$
  		'skip$
  		{note "note" output.check}
  	if$
  	fin.entry
}

FUNCTION {book}
{ output.bibitem
  	author empty$
    	{ editor.full output
      	  editor format.key output }
    	{ author.full output
      	  author format.key output }
  	if$  
  	new.block
  	format.year.par output
  	new.block
  	format.title emphasize output
  	edition empty$ %% Priority to edition
  		{ version empty$
  			'skip$
  			{ format.version tie.or.space.connect }
  			if$ }
  		{ format.edition.par tie.or.space.connect } 
  	if$ 
  	new.block
  	format.addr.publish output
  	new.block
  	format.doi.or.url output
   	fin.entry
}

FUNCTION {incollection}
{  output.bibitem
	author empty$
    	{ editor.full output
      	  editor format.key output }
    	{ author.full output
      	  author format.key output }
  	if$  
  	new.block
  	format.year.par output
  	new.block
  	format.title output
	new.block
	author empty$
    	{ format.booktitle emphasize output}
    	{ format.booktitle.editor output }
    if$
	edition empty$ volume empty$ chapter empty$ pages empty$ and and and
		'skip$
		{ format.edition.vol.chap.pages.par tie.or.space.connect }
	if$
	new.block
  	format.addr.publish output
  	new.block
  	format.doi.or.url output
   	fin.entry
}

FUNCTION {inbook} { incollection}

FUNCTION {inproceedings}
{ output.bibitem
	author.full output
  	author format.key output
  	new.block
  	format.year.month.par output
  	new.block
  	type empty$
  		{ format.title output
			new.block
			format.booktitle emphasize output
			volume empty$ series empty$ number empty$ and and
				{ format.pages output }
				{ format.vol.number.or.series output
					pages "pages" output.check }
			if$ }
		{ format.title emphasize output
			new.block
			booktitle empty$
				'skip$
				{format.proceedings.type output
					format.booktitle tie.or.space.connect }
				if$
			address empty$
				'skip$
				{ address "address" output.check }
			if$
			pages empty$
				'skip$
				{"~" * format.pages.par tie.or.space.connect }
			if$
		 }
	if$
	new.block
  	format.doi.or.url output
  	fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {mastersthesis}
{ output.bibitem
	author.full output
  	author format.key output
  	new.block
  	format.year.par output
  	new.block
  	format.title emphasize output
  	new.block
  	format.master.school.address output
    new.block
    format.note.or.url output
  	fin.entry
}

FUNCTION {phdthesis}
{output.bibitem
	author.full output
  	author format.key output
  	new.block
  	format.year.par output
  	new.block
  	format.title emphasize output
  	new.block
  	format.phd.school.address output
    new.block
    format.note.or.url output
  	fin.entry
}

FUNCTION {techreport}
{ output.bibitem
	author.full output
  	author format.key output
  	new.block
  	format.year.par output
  	new.block
  	format.title emphasize output
  	number empty$
  		'skip$
  		{ format.rap.number.par tie.or.space.connect }
  	if$
  	new.block
  	format.addr.publish output
  	new.block
  	format.url output
   	fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
	author.full output
  	author format.key output
  	new.block
  	format.year.par output
  	new.block
	format.title emphasize output
  	new.block
  	type empty$
  		'skip$
  		{type "type" output.check}
  	if$
  	institution empty$
  		'skip$
  		{institution "institution" output.check}
  	if$
  	address empty$
  		'skip$
  		{address "address" output.check}
  	if$  	
  	note empty$
  		'skip$
  		{note "note" output.check}
  	if$
	new.block  	
  	format.url output
  	fin.entry
}

FUNCTION {online}
{ output.bibitem
	author.full output
  	author format.key output
  	new.block
  	format.note.bra output
  	new.block
  	format.year.month.day.par output
  	new.block
  	format.title output
  	type empty$
  		'skip$
  		 { format.type.bra tie.or.space.connect }
  	if$
  	new.block
  	format.url output
   	fin.entry
}

FUNCTION {patent}
{ output.bibitem
	author.full output
  	author format.key output
  	new.block
  	format.year.par output
	new.block
	format.patent.type.number emphasize output
	new.block
	format.addr.organization output
   	fin.entry
}

FUNCTION {misc}
{ output.bibitem
	author empty$
		 { organization empty$
		 		'skip$
		 		{ organization "organization" output.check
		 			organization format.key output}
		 	if$}
		{ author.full output
  			author format.key output }
  	if$
  	new.block
  	format.year.par output
	new.block
	booktitle empty$
		{ title empty$
			'skip$
			 { title "title" output.check}
			if$ }
		{ title empty$
			'skip$
			 { title emphasize "title" output.check
			 	new.block}
		  	if$ }
	if$
	booktitle empty$
			'skip$
			 { booktitle "booktitle" output.check}
	if$
	version empty$
		'skip$
		{ format.version.par tie.or.space.connect}
	if$
	type empty$
  		'skip$
  		 { format.type.bra tie.or.space.connect }
  	if$
  	new.block
  	address empty$ publisher empty$ and
  		{ institution empty$
  			'skip$
  			{ institution "institution" output.check }
  		if$}
  		{ format.addr.publish output }
  	if$
  	new.block
  	note empty$
  		'skip$
  		{note "note" output.check}
  	if$
  	format.doi.or.url output
   	fin.entry
}

FUNCTION {default.type} { misc }

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {format.lab.names}
{ 's :=
  s #1 "{vv~}{ll}" format.name$
  s num.names$ duplicate$
  #2 >
    { pop$ " et~al." emphasize * }
    { #2 <
        'skip$
        { s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            { " et~al." emphasize * }
            { "~\&~" * s #2 "{vv~}{ll}" format.name$ * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.key.organization.label}
{ author empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.organization.label}
{ editor empty$
    { key empty$
        { organization empty$
            { cite$ #1 #3 substring$ }
            { "The " #4 organization chop.word #3 text.prefix$ }
          if$
        }
        'key
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {calc.short.authors}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.organization.label
        { type$ "misc" =
            'author.key.organization.label
            'author.key.label
          if$
        }
      if$
    }
  if$
  'short.list :=
}

FUNCTION {calc.label}
{ calc.short.authors
  short.list
  "("
  *
  year duplicate$ empty$
  short.list key field.or.null = or
     { pop$ "" }
     'skip$
  if$
  *
  'label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    {
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr #1 >
        {
          "   "  *
          namesleft #1 = t "others" = and
            { "zzzzz" * }
            { numnames #2 > nameptr #2 = and
                { "zz" * year field.or.null * "   " * }
                'skip$
              if$
              t sortify *
            }
          if$
        }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to sort, need author, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to sort, need editor, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}


FUNCTION {presort}
{ calc.label
  label sortify
  "    "
  *
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "misc" =
            'author.organization.sort
            'author.sort
          if$
        }
      if$
    }
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  cite$
  *
  #1 entry.max$ substring$
  'sort.label :=
  sort.label *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label last.label next.extra }

INTEGERS { longest.label.width last.extra.num number.label }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
  #0 'number.label :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  number.label #1 + 'number.label :=
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ empty$
    'skip$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
  label extra.label * 'label :=
}

EXECUTE {initialize.longest.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {bib.sort.order}
{ sort.label  'sort.key$ :=
}

ITERATE {bib.sort.order}

SORT

FUNCTION {begin.bib}
{   preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{" number.label int.to.str$ * "}" *
  write$ newline$
  "\providecommand{\natexlab}[1]{#1}"
  write$ newline$
  "\providecommand{\url}[1]{\texttt{#1}}"
  write$ newline$
  "\expandafter\ifx\csname urlstyle\endcsname\relax"
  write$ newline$
  "  \providecommand{\doi}[1]{doi: #1}\else"
  write$ newline$
  "  \providecommand{\doi}{doi: \begingroup \urlstyle{rm}\Url}\fi"
  write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}