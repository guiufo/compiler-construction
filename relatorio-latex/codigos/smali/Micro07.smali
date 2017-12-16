.class public LMicro07;
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
    .registers 7
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 8
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2}, Ljava/lang/String;-><init>()V

    .line 9
    .local v2, "opc":Ljava/lang/String;
    new-instance v0, Ljava/util/Scanner;

    sget-object v4, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v0, v4}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 11
    .local v0, "leitor":Ljava/util/Scanner;
    const/4 v3, 0x1

    .line 13
    .local v3, "programa":I
    :cond_d
    :goto_d
    const/4 v4, 0x1

    if-ne v3, v4, :cond_48

    .line 14
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v5, "Digite um n\u00famero: "

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 15
    invoke-virtual {v0}, Ljava/util/Scanner;->nextInt()I

    move-result v1

    .line 17
    .local v1, "numero":I
    if-lez v1, :cond_35

    .line 18
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v5, "Positivo"

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 29
    :cond_24
    :goto_24
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v5, "Deseja finalizar? (S/N) "

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 30
    invoke-virtual {v0}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v2

    .line 31
    const-string v4, "S"

    if-ne v2, v4, :cond_d

    .line 32
    const/4 v3, 0x0

    goto :goto_d

    .line 21
    :cond_35
    if-nez v1, :cond_3e

    .line 22
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v5, "O numero eh igual a 0"

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 24
    :cond_3e
    if-gez v1, :cond_24

    .line 25
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v5, "O numero eh negativo"

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_24

    .line 35
    .end local v1    # "numero":I
    :cond_48
    return-void
.end method
