// TODO: Add support for multiple partitions, not just C:
if (!FileFind("C:/Apps/Wordle",,FUF_JUST_DIRS)) {
    "Installing...\n";
    DirMk("C:/Apps/Wordle");
} else "Updating...\n";
CopyTree("T:/", "C:/Apps/Wordle");
Del("C:/Apps/Wordle/RunCD.*");
"Done!\n";
