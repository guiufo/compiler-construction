.class public Lcom/hello/android/hello/Micro09;
.super Ljava/lang/Object;
.source "Micro09.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .registers 11
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 8
    const-wide/16 v4, 0x0

    .line 9
    .local v4, "preco":D
    const-wide/16 v6, 0x0

    .line 10
    .local v6, "venda":D
    const-wide/16 v2, 0x0

    .line 11
    .local v2, "novo_preco":D
    new-instance v0, Ljava/util/Scanner;

    sget-object v1, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v0, v1}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 13
    .local v0, "leitor":Ljava/util/Scanner;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v8, "Digite o preco: "

    invoke-virtual {v1, v8}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 14
    invoke-virtual {v0}, Ljava/util/Scanner;->nextDouble()D

    move-result-wide v4

    .line 15
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v8, "Digite a venda: "

    invoke-virtual {v1, v8}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 16
    invoke-virtual {v0}, Ljava/util/Scanner;->nextDouble()D

    move-result-wide v6

    .line 18
    const-wide v8, 0x407f400000000000L    # 500.0

    cmpg-double v1, v6, v8

    if-ltz v1, :cond_32

    const-wide/high16 v8, 0x403e000000000000L    # 30.0

    cmpg-double v1, v4, v8

    if-gez v1, :cond_50

    .line 20
    :cond_32
    const-wide/16 v8, 0x0

    mul-double/2addr v8, v4

    add-double v2, v4, v8

    .line 37
    :cond_37
    :goto_37
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "O novo preco eh "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v8}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 38
    return-void

    .line 24
    :cond_50
    const-wide v8, 0x407f400000000000L    # 500.0

    cmpl-double v1, v6, v8

    if-ltz v1, :cond_62

    const-wide v8, 0x4092c00000000000L    # 1200.0

    cmpg-double v1, v6, v8

    if-ltz v1, :cond_6e

    :cond_62
    const-wide/high16 v8, 0x403e000000000000L    # 30.0

    cmpl-double v1, v4, v8

    if-ltz v1, :cond_74

    const-wide/high16 v8, 0x4054000000000000L    # 80.0

    cmpg-double v1, v4, v8

    if-gez v1, :cond_74

    .line 26
    :cond_6e
    const-wide/16 v8, 0x0

    mul-double/2addr v8, v4

    add-double v2, v4, v8

    goto :goto_37

    .line 30
    :cond_74
    const-wide v8, 0x4092c00000000000L    # 1200.0

    cmpl-double v1, v6, v8

    if-gez v1, :cond_83

    const-wide/high16 v8, 0x4054000000000000L    # 80.0

    cmpl-double v1, v4, v8

    if-ltz v1, :cond_37

    .line 32
    :cond_83
    const-wide/16 v8, 0x0

    mul-double/2addr v8, v4

    sub-double v2, v4, v8

    goto :goto_37
.end method
