.class public Lcom/hello/android/hello/Micro11;
.super Ljava/lang/Object;
.source "Micro11.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .registers 6
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 8
    new-instance v0, Ljava/util/Scanner;

    sget-object v3, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v0, v3}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 10
    .local v0, "leitor":Ljava/util/Scanner;
    const/4 v1, 0x0

    .line 11
    .local v1, "numero":I
    const/4 v2, 0x0

    .line 13
    .local v2, "x":I
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v4, "Digite um n\u00famero: "

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 14
    invoke-virtual {v0}, Ljava/util/Scanner;->nextInt()I

    move-result v1

    .line 16
    invoke-static {v1}, Lcom/hello/android/hello/Micro11;->verifica(I)I

    move-result v2

    .line 18
    const/4 v3, 0x1

    if-ne v2, v3, :cond_23

    .line 19
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v4, "N\u00famero positivo."

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 29
    :goto_22
    return-void

    .line 22
    :cond_23
    if-nez v2, :cond_2d

    .line 23
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v4, "Zero."

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_22

    .line 26
    :cond_2d
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v4, "N\u00famero negativo."

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_22
.end method

.method public static verifica(I)I
    .registers 2
    .param p0, "numero"    # I

    .prologue
    .line 33
    const/4 v0, 0x0

    .line 34
    .local v0, "res":I
    if-lez p0, :cond_5

    .line 35
    const/4 v0, 0x1

    .line 45
    :goto_4
    return v0

    .line 38
    :cond_5
    if-gez p0, :cond_9

    .line 39
    const/4 v0, -0x1

    goto :goto_4

    .line 42
    :cond_9
    const/4 v0, 0x0

    goto :goto_4
.end method
