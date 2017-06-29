#!/bin/bash
thisdir=`dirname $0`
SINGULAR="bachelor|gentleman|scholar|[A-Za-z]+er(?<!soldier)"
PLURAL="bachelors|gentlemen|scholars|[A-Za-z]+ers(?<!soldiers)"
. $thisdir/egrep-assert-present.cmds
. $thisdir/egrep-assert-past.cmds
