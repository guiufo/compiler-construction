.class public LMicro04;
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
    .registers 8
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 7
    new-instance v1, Ljava/util/Scanner;

    sget-object v4, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v1, v4}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 9
    .local v1, "leitor":Ljava/util/Scanner;
    const/4 v0, 0x0

    .line 11
    .local v0, "intervalo":I
    const/4 v3, 0x1

    .local v3, "x":I
    :goto_9
    const/4 v4, 0x5

    if-gt v3, v4, :cond_24

    .line 13
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v5, "Digite um numero: "

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 14
    invoke-virtual {v1}, Ljava/util/Scanner;->nextInt()I

    move-result v2

    .line 15
    .local v2, "num":I
    const/16 v4, 0xa

    if-lt v2, v4, :cond_21

    .line 17
    const/16 v4, 0x96

    if-gt v2, v4, :cond_21

    .line 19
    add-int/lit8 v0, v0, 0x1

    .line 11
    :cond_21
    add-int/lit8 v3, v3, 0x1

    goto :goto_9

    .line 24
    .end local v2    # "num":I
    :cond_24
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Ao total, foram digitados "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " numeros no intervalo entre 10 e 150"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 25
    return-void
.end method
