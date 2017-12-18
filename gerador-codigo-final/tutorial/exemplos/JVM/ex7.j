.source ex7.java
.class  ex7 
.super  java/lang/Object

.field public static a I
.field public static b I
.field public static soma I


.method public <init>()V
   aload_0
   invokespecial java/lang/Object/<init>()V
   return
.end method

.method public static somador(III)I
   .limit stack 3
   .limit locals 5

   iconst_1
   istore        4
   iload         4
   iload_0
   iload_1
   iadd
   iload_2
   iadd
   imul
   istore_3
   iload_3
   ireturn
.end method

.method  public static main([Ljava.lang.String;)V
   .limit stack 5

   iconst_2
   putstatic     ex7/a I
   iconst_3
   putstatic     ex7/b I
   getstatic     ex7/a I
   iconst_1
   iadd
   getstatic     ex7/b I
   iconst_2
   iadd
   iconst_5
   invokestatic  ex7/somador(III)I
   putstatic     ex7/soma I
   getstatic     java/lang/System.out Ljava/io/PrintStream;
   getstatic     ex7/a I
   invokevirtual java/io/PrintStream.println(I)V
   getstatic     java/lang/System.out Ljava/io/PrintStream;
   getstatic     ex7/b I
   invokevirtual java/io/PrintStream.println(I)V
   getstatic     java/lang/System.out Ljava/io/PrintStream;
   getstatic     ex7/soma I
   invokevirtual java/io/PrintStream.println(I)V
   return
.end method
