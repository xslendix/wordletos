U0 UserStartUp()
{
    DocTermNew;
    LBts(&Fs->display_flags, DISPLAYf_SHOW);
    WinToTop;
    WinZBufUpdate;
    Dir;
}

U0 SrvStartUp()
{
    DocTermNew;
    LBts(&Fs->display_flags, DISPLAYf_SHOW);
    WinToTop;
    WinZBufUpdate;
}

U0 StartUpTasks()
{
    CTask *user1;
    user1 = User;
    WinToTop(user1);
    WinMax(user1);
    "Boot time: %7.3fs\n", tS;
    XTalk(user1, "Cd;#include \"Once\";\n");
    Silent;
    ACInit("/*;!*/Bible.TXT*");
    Silent(OFF);
}

StartUpTasks;

"\nTempleOS V%5.3f\t%D %T\n\n", sys_os_version, sys_compile_time, sys_compile_time;
