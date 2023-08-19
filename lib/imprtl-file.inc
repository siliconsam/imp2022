%endoflist
{----------------------------------------------------------------------------}
    ! External Library routines implemented in C
    ! N.B. These routines need an alias name referring to the actual C routine
    !      Also the alias name may need to be changed for different operating systems
    ! imprtl routines implemented in C to access C standard file handles,error status,write a double length real
    %external %routine     %spec prim exit            %alias "exit" ( %integer status )
    %external %integer %fn %spec prim geterr          %alias "geterrno"
    %external %integer %fn %spec prim geterrhandle    %alias "getstderr"
    %external %integer %fn %spec prim getinhandle     %alias "getstdin"
    %external %integer %fn %spec prim getouthandle    %alias "getstdout"

    %external %integer %fn %spec prim openfile        %alias "fopen" ( %integer mode address, %integer file name address )
    %external %integer %fn %spec prim tell            %alias "ftell" ( %integer handle )
    %external %routine     %spec prim file rewind     %alias "rewind" ( %integer handle )
    %external %routine     %spec prim file seek       %alias "fseek" ( %integer handle, displacement, pos )
    %external %routine     %spec prim close           %alias "fclose" ( %integer handle )
    %external %integer %fn %spec prim readbytes       %alias "fread" ( %integer handle, count, itemsz, %byte %name buffer )
    %external %integer %fn %spec prim writebytes      %alias "fwrite" ( %integer handle, count, itemsz, %byte %name buffer )
    %external %integer %fn %spec prim eof             %alias "feof" ( %integer handle )
    %external %integer %fn %spec prim get char        %alias "fgetc" ( %integer handle )
    %external %routine     %spec prim put char        %alias "fputc" ( %integer handle,ch )
    %external %routine     %spec prim flush           %alias "fflush" ( %integer handle )
{----------------------------------------------------------------------------}
%list
%endoffile
