NAME = scrawl
EXT = exe

GOALS = $(NAME).$(EXT)

LIBS    =kernel32.lib user32.lib advapi32.lib \
         comdlg32.lib gdi32.lib winmm.lib libc.lib comctl32.lib \
         dinput.lib dxguid.lib

OBJS    =  scrawl.obj

!if "$(DEBUG)" == "debug"
COPT =-YX -DDEBUG -Zi -Fd$(NAME).PDB
LOPT =-debug:full -debugtype:cv -pdb:$(NAME).pdb
ROPT =-DDEBUG
!else
COPT =-YX
LOPT =-debug:none
ROPT =
!endif
RES = $(NAME).res 

CFLAGS  =$(COPT) -Oxa -D_X86_ $(CDEBUG) -Fo$@
LFLAGS  =$(LOPT)
RCFLAGS =$(ROPT)

NOLOGO = 1

!include ..\..\mssdk.mk

$(NAME).$(EXT): \
    $(OBJS) $(RES)
    @$(LINK) $(LFLAGS) @<<
-out:$(NAME).$(EXT)
-map:$(NAME).map
-machine:i386
-subsystem:windows,4.0
$(LIBS)
$(RES)
$(OBJS)
<<
