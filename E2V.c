#include "stdio.h"
#include "string.h"
#include "stdlib.h"
#define INS_NO 62

char str[200];
int file_len = 0;
char file_buff[1000][100];
char ins_buff[1000][100];
int ins_cnt=0;
char t[300];

char*skipspace(char * str)
{
int i = 299,j=0;
while(i--)
t[i]=0;
i=0;
while(str[i]==' ')i++;
while(str[i]!='\0')
{
t[j]=str[i];
j++;i++;
}
t[j]='\0';
return t;
}

int read_file1(char *fn)
{
int ret=0,i=0;
FILE *f = fopen(fn,"r");
if (NULL==f){printf("can not read file %s\n",fn);getchar();return 0;}
while(fgets(file_buff[i],200,f))
{
i++;
ret++;
}
ret++;
file_len=ret;
return ret;
}

char ctl_arg[200][200],ctl_name[200][200];

int ex2ver(char *fn ,char*ft){
int i,j,ret=0;
FILE *f=fopen(fn,"r");
FILE *t=fopen(ft,"w");
if (NULL==f)
    {
    printf("can not openfile to read %s!\n",fn);
    getchar();
    return 0;
    }
    
fgets(str,200,f);

sscanf(str,""%s%s%s%s%s%s%s%s%s%s",

ctl_name[1],ctl_name[2],ctl_name[3],ctl_name[4],
ctl_name[5],ctl_name[6],ctl_name[7],ctl_name[8],
ctl_name[9],ctl_name[10],
/*  ctl_name[11],ctl_name[12],ctl_name[13] */
);
/*

printf("hello now\n");
for(i=1;i<13;++i)

*/

/*  printf(">%s<\n",ctl_name[i]); */
for(i=0;i<INS_NO;++i)
{
    fgets(str,200,f);
    sscanf(str,"%s%s%s%s%s%s%s%s%s%s%s",
    ctl_arg[0],
    ctl_arg[1],ctl_arg[2],ctl_arg[3],ctl_arg[4],ctl_arg[5],ctl_arg[6],ctl_arg[7],ctl_arg[8],ctl_arg[9],ctl_arg[10],
 /*    ctl_arg[11],ctl_arg[12],ctl_arg[13] */
    );
    for(j=1;j<14;++j)/*  */
    {
        sprintf(ins_buff[ins_cnt++],"//replaceID  = `%s ;\n",ctl_arg[0]);
        fprintf(t,"//replaceID  = `%s ;\n",ctl_arg[0]);
     /*    printf("//replaceID  = `%s ;\n",ctl_arg[0]); */
        for(j=1;j<14;++j)
        {
                sprintf(ins_buff[ins_cnt++],"         %s = `%s;\n",ctl_name[j],ctl_arg[j]);
                fprintf(t,"         %s = `%s;\n",ctl_name[j],ctl_arg[j]);
        }
        fprintf(t,"//end of `%s ;\n/**/\n",ctl_arg[0]);\
        sprintf(ins_buff[ins_cnt++],"//end of `%s ;\n\n",ctl_arg[0]);
    }
}
    sprintf(ins_buff[ins_cnt++],"\n");
    sprintf(ins_buff[ins_cnt++],"\n");
     fclose(t);
     fclose(f);
}
void skipspaceinbuffer(int len){
int i=0;
for(i=0;i<len;++i)
strcpy(file_buff[i],skipspace(file_buff[i]));
}
FILE *f_g ; 
void init_f(char *fn)
{
f_g=fopen(fn,"r");
}

int find(char *str_i,char*fn)
{
int i =0;
/*  printf("find()str_i=%s\n",str_i); */
ins_cnt=0;
rewind(f_g);
/*  if (strncmp(str_i,"//replaceID  =",strlen("//replaceID"))!=0) */
/*  {return 0;} */
while(fgets(str,200,f_g))
{
/*  printf(">str_i=%s<",str_i); */
/*  printf(">str=%s<",str); */
/*  if (strncmp(str,str_i,strlen("//replaceID  = `1234"))==0) */
  if (strcmp(str,str_i)==0)
  {
/*  printf(">%s<",str); */
    while (fgets(str,200,f_g))
    {
      if (strncmp(str,"/**/",4)!=0)
      {
         strcpy(ins_buff[ins_cnt++],str);
      }
      else 
      {
        return ins_cnt;
      }
    }
  }
}  return 0;
}
void cpynrp(char *fn)
{
int i = 0 ,j,ret;
FILE *f = fopen(fn,"w");
/* printf("OK now,you can drink a cup of coffee,or you can take a short walk...\nThis runtine will take a long time!\n"); */
for(i=0;i<file_len;++i)
{
    fprintf(f,"%s",file_buff[i]);
    ret==find(file_buff[i],"ins.txt");
    if (ins_cnt!=0)
    {
      /*   printf("cpnynrp()==>ret!=0\n"); */
        for(j=0;j<ins_cnt;++j)
        {
        /*         printf("%s",ins_buff[j]); */
                fprintf(f,"%s",ins_buff[j]);
        }
    }
}
}

main(){
int len,i;
init();

ex2ver("BOOK1.txt","ins.txt");/*we first create a temp file anmed as ins.txt*/
len = read_file1("decoder.v");/*read file to buffer*/
init_f("ins.txt"); /**/
skipspaceinbuffer(len);
cpynrp("decodr.v");
}
