#!/bin/bash
thisdir=`dirname $0`
SINGULAR='bachelor|gentleman|scholar|([A-Za-z]+er(?<!soldier|never|ever|(ma|be)tter))'
PLURAL='bachelors|gentlemen|scholars|([A-Za-z]+ers(?<!soldiers|(ma|be)tters))'
. $thisdir/egrep-assert-present.cmds
. $thisdir/egrep-assert-past.cmds
