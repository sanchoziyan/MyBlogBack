/*创建数据表空间   其中存放数据表空间的目录必须已经存在*/
create tablespace dbsp_myblog datafile 'F:\oracle\app\dbmyblog.dbf'
size 10m
extent management local autoallocate;

select tablespace_name,file_name,bytes from dba_data_files;
/*创建用户*/
create user myblog identified by myblog
default tablespace dbsp_myblog
temporary tablespace temp
quota 10m on dbsp_myblog;
/*给用户赋予权限*/
grant connect,resource to myblog;
/**解锁用户**/
alter user myblog account unlock;
/**删除用户语句：
　　drop user 用户名 cascade;
　　   删除空的表空间，但是不包含物理文件
　　drop tablespace tablespace_name;
　　　删除非空表空间，但是不包含物理文件
　　drop tablespace tablespace_name including contents;
　　　删除空表空间，包含物理文件
　　drop tablespace tablespace_name including datafiles; 
　　　删除非空表空间，包含物理文件
　　drop tablespace tablespace_name including contents and datafiles;
　　　如果其他表空间中的表有外键等约束关联到了本表空间中的表的字段，就要加上CASCADE CONSTRAINTS
drop tablespace tablespace_name including contents and datafiles CASCADE CONSTRAINTS;
**/
/**************************创建表 TSlideshow  TAdmin TUser  TCategory TNews  THotNews TPlun  
TRole TROLE_RIGHT 
*************************/

/* 轮播图 */
create table TSlideshow  (
   imgUrl             VARCHAR2(200),
   description        VARCHAR2(200),
   state              VARCHAR2(200),
   num                VARCHAR2(200),
   uuid	VARCHAR2(200) not null,
   constraint PK_TSlideshow primary key (uuid)
);

comment on table TSlideshow is
'轮播图';

comment on column TSlideshow.imgUrl is
'地址路径';

comment on column TSlideshow.description is
'描述';

comment on column TSlideshow.state is
'所属';

comment on column TSlideshow.num is
'序号';


/*管理员*/
create table TAdmin  (
   uname              varchar2(30)                    not null,
   pwd                varchar2(30)                   not null,
   role               char(1)                         not null,
   constraint PK_TADMIN primary key (uname)
);
comment on table TAdmin is
'管理员';

comment on column TAdmin.uname is
'用户名';

comment on column TAdmin.pwd is
'密码';

comment on column TAdmin.role is
'角色';

/*普通用户*/
create table TUser  (
   uname              varchar2(30)                    not null,
   pwd                varchar2(30)                    not null,
   role               char(1)                         not null,
   constraint PK_TUSER primary key (uname)
);
comment on table TUser is
'用户';

comment on column TUser.uname is
'用户名';

comment on column TUser.pwd is
'密码';

comment on column TUser.role is
'角色';

/*分类*/
create table TCategory  (
   cid                varchar2(18)                    not null,
   cname              varchar2(8)                     not null,
   constraint PK_TCATEGORY primary key (cid)
);
comment on table TCategory is
'新闻分类';

comment on column TCategory.cid is
'分类ID';

comment on column TCategory.cname is
'分类名称';

/*新闻*/
create table TNews  (
   nid                varchar2(30)                    not null,
   cid                varchar2(18),
   title              varchar2(120),
   pubtime            date,
   info               clob,
   state              number(1),
   constraint PK_TNEWS primary key (nid)
);
comment on table TNews is
'新闻';

comment on column TNews.nid is
'新闻ID';

comment on column TNews.cid is
'分类ID';

comment on column TNews.title is
'标题';

comment on column TNews.pubtime is
'发布时间';

comment on column TNews.info is
'新闻内容';

comment on column TNews.state is
'1  正常
0  下架
';

alter table TNews
   add constraint FK_TNEWS_REFERENCE_TCATEGOR foreign key (cid)
      references TCategory (cid);
      
/*热点新闻*/
create table THotNews  (
   nid                varchar2(30)                    not null,
   constraint PK_THOTNEWS primary key (nid)
);

comment on column THotNews.nid is
'新闻ID';

alter table THotNews
   add constraint FK_THOTNEWS_REFERENCE_TNEWS foreign key (nid)
      references TNews (nid);
      
/*评论*/
create table TPlun  (
   pid                number(9)                       not null,
   uname              varchar2(30),
   nid                varchar2(30),
   pinfo              varchar2(300)                   not null,
   ptime              date,
   zan                number(9)                      default 0,
   cai                number(9)                      default 0,
   constraint PK_TPLUN primary key (pid)
);

comment on table TPlun is
'评论';

comment on column TPlun.pid is
'pid';

comment on column TPlun.uname is
'用户名';

comment on column TPlun.nid is
'新闻ID';

comment on column TPlun.pinfo is
'评论内容';

comment on column TPlun.ptime is
'评论时间';

comment on column TPlun.zan is
'点赞次数';

comment on column TPlun.cai is
'踩次数';

alter table TPlun
   add constraint FK_TPLUN_REFERENCE_TUSER foreign key (uname)
      references TUser (uname);

alter table TPlun
   add constraint FK_TPLUN_REFERENCE_TNEWS foreign key (nid)
      references TNews (nid);

drop table TRole cascade constraints;

/*==============================================================*/
/* Table: TRole                                               */
/*==============================================================*/
create table TRole  (
   roid               char(1)                         not null,
   roname             VARCHAR2(100),
   constraint PK_TROLE primary key (roid)
);

comment on table TRole is
'角色';

comment on column TRole.roid is
'角色ID';

comment on column TRole.roname is
'角色名';
drop table TROLE_RIGHT cascade constraints;

/*==============================================================*/
/* Table: TROLE_RIGHT                                           */
/*==============================================================*/
create table TROLE_RIGHT  (
   roid               char(1),
   rid                varchar2(32)
);

comment on table TROLE_RIGHT is
'角色权限表';

comment on column TROLE_RIGHT.roid is
'角色ID';

comment on column TROLE_RIGHT.rid is
'权限ID';

alter table TROLE_RIGHT
   add constraint FK_TROLE_RI_REFERENCE_TROLE foreign key (roid)
      references TRole (roid);

alter table TROLE_RIGHT
   add constraint FK_TROLE_RI_REFERENCE_TRIGHT foreign key (rid)
      references TRight (rid);

drop table TRight cascade constraints;

/*==============================================================*/
/* Table: TRight                                              */
/*==============================================================*/
create table TRight  (
   rid                varchar2(32)                    not null,
   rname              varchar2(80),
   rurl               varchar2(100),
   constraint PK_TRIGHT primary key (rid)
);

comment on table TRight is
'权限';

comment on column TRight.rid is
'权限id';

comment on column TRight.rname is
'权限名';

comment on column TRight.rurl is
'权限URL';

      
      
      
      