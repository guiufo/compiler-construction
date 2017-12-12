.class public LMicro03;
.super Ljava/lang/Object;

# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .registers 5
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 8
    new-instance v1, Ljava/util/Scanner;

    sget-object v2, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v1, v2}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 10
    .local v1, "reader":Ljava/util/Scanner;
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Digite um n\u00famero: "

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 11
    invoke-virtual {v1}, Ljava/util/Scanner;->nextInt()I

    move-result v0

    .line 12
    .local v0, "num":I
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Digite o segundo n\u00famero: "

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 15
    const/16 v2, 0x64

    if-lt v0, v2, :cond_31

    .line 17
    const/16 v2, 0xc8

    if-gt v0, v2, :cond_29

    .line 19
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "O numero esta no intervalo entre 100 e 200"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 30
    :goto_28
    return-void

    .line 23
    :cond_29
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "O numero nao esta no intervalo entre 100 e 200"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_28

    .line 28
    :cond_31
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "O numero nao esta no intervalo entre 100 e 200"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_28
.end method
