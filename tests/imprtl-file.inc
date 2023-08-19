%endoflist
{----------------------------------------------------------------------------}
    ! External Library routines implemented in C
    ! N.B. These routines need an alias name referring to the actual C routine
    !      Also the alias name may need to be changed for different operating systems
    ! imprtl routines implemented in C to access C standard file handles,error status,write a double length real
    %external %routine     %spec prim exit            %alias "_exit" ( %integer status )
    %external %integer %fn %spec prim geterr          %alias "_geterrno"
    %external %integer %fn %spec prim geterrhandle    %alias "_getstderr"
    %external %integer %fn %spec prim getinhandle     %alias "_getstdin"
    %external %integer %fn %spec prim getouthandle    %alias "_getstdout"

    %external %integer %fn %spec prim openfile        %alias "_fopen" ( %integer mode address, %integer file name address )
    %external %integer %fn %spec prim tell            %alias "_ftell" ( %integer handle )
    %external %routine     %spec prim file rewind     %alias "_rewind" ( %integer handle )
    %external %routine     %spec prim file seek       %alias "_fseek" ( %integer handle, displacement, pos )
    %external %routine     %spec prim close           %alias "_fclose" ( %integer handle )
    %external %integer %fn %spec prim readbytes       %alias "_fread" ( %integer handle, count, itemsz, %byte %name buffer )
    %external %integer %fn %spec prim writebytes      %alias "_fwrite" ( %integer handle, count, itemsz, %byte %name buffer )
    %external %integer %fn %spec prim eof             %alias "_feof" ( %integer handle )
    %external %integer %fn %spec prim get char        %alias "_fgetc" ( %integer handle )
    %external %routine     %spec prim put char        %alias "_fputc" ( %integer handle,ch )
    %external %routine     %spec prim flush           %alias "_fflush" ( %integer handle )
{----------------------------------------------------------------------------}
%list
%endoffile
