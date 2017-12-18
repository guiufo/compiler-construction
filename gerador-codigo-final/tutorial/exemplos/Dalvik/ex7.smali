.class Lex7;
.super Ljava/lang/Object;
.source "ex7.java"


# static fields
.field static a:I
.field static b:I
.field static soma:I


# direct methods
.method constructor <init>()V
    .registers 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .registers 4

    .prologue
    const/4 v0, 0x2
    sput v0, Lex7;->a:I
    const/4 v0, 0x3
    sput v0, Lex7;->b:I
    sget v0, Lex7;->a:I
    add-int/lit8 v0, v0, 0x1
    sget v1, Lex7;->b:I
    add-int/lit8 v1, v1, 0x2
    const/4 v2, 0x5
    invoke-static {v0, v1, v2}, Lex7;->somador(III)I
    move-result v0
    sput v0, Lex7;->soma:I
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;
    sget v1, Lex7;->a:I
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(I)V
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;
    sget v1, Lex7;->b:I
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(I)V
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;
    sget v1, Lex7;->soma:I
    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(I)V
    return-void
.end method

.method static somador(III)I
    .registers 5

    .prologue
    const/4 v0, 0x1
    add-int v1, p0, p1
    add-int/2addr v1, p2
    mul-int/2addr v0, v1
    return v0
.end method
