BEGIN {
    FS=" ";
    id=1;
}

{
    printf("fact_%d %s nil\n", id, $2);
    printf("fact_%d subject %s\n", id, $1);
    printf("fact_%d object %s\n\n", id, $3);
    id += 1;
}
