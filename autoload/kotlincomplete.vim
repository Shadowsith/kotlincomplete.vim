"Vim completion script
"Language: Kotlin
"

fun! IsValDeclaration()
    let l:val = getline(".")
    let l:parts = split(l:val)
    if len(l:parts) > 0 && l:parts[0] =~ 'val'
        if strpart(l:parts[1], len(l:parts[1])-1) =~ ':' 
            return 0
        endif
    else
        return 1
    endif
endfun

fun! kotlincomplete#CompleteKT(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " find keywords with "a:base"
        let res = [] 
        let l:test = 0
        let l:test = IsValDeclaration()
        if l:test == 0
            for m in g:kotlin_basetypes 
                if m =~ '^' . a:base
                    call add(res, m)
                endif
            endfor
        else
            for m in g:kotlin_keywords
                "if m =~ '^' . a:base
                if l:m[0] !~? '^' . a:base && l:m[1] !~? '^' . a:base
                    " Doesn't match
                    continue
                endif
                call add(res, {
                            \'icase': 20,
                            \'word': m[0],
                            \'abbr': m[0],
                            \'menu': m[1],
                            \'info': m[2],
                            \ })
            endfor
        endif
        let g:curpos = getcurpos() 
        call complete(a:findstart + g:curpos[2], res)
        return ''
    endif
endfun

let g:kotlin_keywords = [
            \ ['abstract', '', 'keyword for abstract classes'],
            \ ['class', '', "class MyClass {}\nInheritance: class B : A()"],
            \ ['catch', '', ' '],
            \ ['else', '', 'if(condition) {...} else {}'],
            \ ['finally', '', ' '],
            \ ['for', '', 'for (item in collection) {/*loop body*/}'],
            \ ['fun', 'function', 'fun myFunc(): Type {}'],
            \ ['if', '', 'if (condition) {}'],
            \ ['import', '', 'Usage: import java.util.*'],
            \ ['infix', '', ' '],
            \ ['inline', '', ' '],
            \ ['interface', '', "interface MyInterface {}\nImplementation: class MyClass : MyInterface {}"],
            \ ['noinline', '', ' '],
            \ ['open', '', ' '],
            \ ['package', '', 'package my.package'],
            \ ['private', '', 'private variables and functions'],
            \ ['public', '', 'public variables and functions'],
            \ ['suspend', '', ' '],
            \ ['try', '', ' '],
            \ ['val', '', ' '],
            \ ['var', '', ' '],
            \ ['vararg', '', ' '],
            \ ['while', '', 'while (condition) {/*loop body*/}'],
            \]


            "\ ['', '', ''],

" let g:kotlin_keywords =    [
"             \'abstract',
"             \'class',
"             \'catch',
"             \'else',
"             \'finally',
"             \'for',
"             \'fun',
"             \'if',
"             \'import',
"             \'infix',
"             \'inline',
"             \'interface',
"             \'noinline',
"             \'open',
"             \'package',
"             \'private',
"             \'public',
"             \'suspend',
"             \'try',
"             \'val',
"             \'var',
"             \'vararg',
"             \'while',
"             \]

let g:kotlin_basetypes =    [
            \'Boolean',
            \'Boolean?',
            \'Byte',
            \'Byte?',
            \'Char',
            \'Char?',
            \'Double',
            \'Double?',
            \'Float',
            \'Float?',
            \'Int',
            \'Int?',
            \'IntArray',
            \'Long',
            \'Long?',
            \'Short',
            \'Short?',
            \'String',
            \]
