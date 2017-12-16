.class public Lcom/hello/android/hello/Micro10;
.super Ljava/lang/Object;
.source "Micro10.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static fatorial(I)I
    .registers 2
    .param p0, "numero"    # I

    .prologue
    .line 18
    if-gtz p0, :cond_4

    const/4 v0, 0x1

    .line 20
    :goto_3
    return v0

    :cond_4
    add-int/lit8 v0, p0, -0x1

    invoke-static {v0}, Lcom/hello/android/hello/Micro10;->fatorial(I)I

    move-result v0

    mul-int/2addr v0, p0

    goto :goto_3
.end method

.method public static main([Ljava/lang/String;)V
    .registers 7
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 8
    const/4 v2, 0x0

    .line 9
    .local v2, "numero":I
    const/4 v0, 0x0

    .line 10
    .local v0, "fat":I
    new-instance v1, Ljava/util/Scanner;

    sget-object v3, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v1, v3}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 11
    .local v1, "leitor":Ljava/util/Scanner;
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v4, "Digite um numero: "

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 12
    invoke-virtual {v1}, Ljava/util/Scanner;->nextInt()I

    move-result v2

    .line 13
    invoke-static {v2}, Lcom/hello/android/hello/Micro10;->fatorial(I)I

    move-result v0

    .line 14
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "O fatorial de "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " e "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 15
    return-void
.end method
