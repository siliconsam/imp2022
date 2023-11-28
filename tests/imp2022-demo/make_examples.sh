#! /bin/bash
#
# Compile the main imp program baggins.imp
#
./compile_imp.sh baggins
#
# Compile bilbo.imp
#
./compile_imp.sh bilbo
./linkrun_prog_object.sh baggins bilbo
#
# Compile bilbo.s
#
./compile_s.sh bilbo_s
./linkrun_prog_assembler.sh baggins bilbo_s
#
# Compile bilbo_s.imp
#
./compile_imp.sh bilbo_i
./linkrun_prog_object.sh baggins bilbo_i
#
# Compile bilbo_d.imp
#
./compile_imp.sh bilbo_d
./linkrun_prog_object.sh baggins bilbo_d
#
# Compile bilbo_e.imp
#
./compile_imp.sh bilbo_e
./linkrun_prog_object.sh baggins bilbo_e
#
# Compile bilbo_ed.imp
#
./compile_imp.sh bilbo_ed
./linkrun_prog_object.sh baggins bilbo_ed
#
#echo ""
#echo "***********************************************************************"
#echo "* Now to test the IMPRTL archive + various bilboX shareable libraries *"
#echo "***********************************************************************"
#echo ""
##
#./form_library.sh bilbo bilbo
#./linkrun_prog_lib.sh baggins bilbo
##
#./form_library.sh bilbo_s bilbo_s
#./linkrun_prog_lib.sh baggins bilbo_s
##
#./form_library.sh bilbo_i bilbo_i
#./linkrun_prog_lib.sh baggins bilbo_i
##
#./form_library.sh bilbo_d bilbo_d
#./linkrun_prog_lib.sh baggins bilbo_d
##
#./form_library.sh bilbo_e bilbo_e
#./linkrun_prog_lib.sh baggins bilbo_e
##
#./form_library.sh bilbo_ed bilbo_ed
#./linkrun_prog_lib.sh baggins bilbo_ed
#
# Tidy up
#
readelf -x1 -x2 -x3 -x4 -x5 -x6 -x7 -x8 -p9 -p10 -A -g -t -a -W bilbo_ed.o > bilbo_ed.imp.readelf.txt
rm -f baggins
#rm *.cod
rm -f *.ibj
rm -f *.icd
rm -f *.lst
#rm *.o
rm -f *.so
