.class public LMicro01;
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
    .registers 11
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 10
    new-instance v4, Ljava/util/Scanner;

    sget-object v5, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v4, v5}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 11
    .local v4, "leitor":Ljava/util/Scanner;
    sget-object v5, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v6, "Tabela de conversao: Celsius -> Fahrenheith"

    invoke-virtual {v5, v6}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 12
    sget-object v5, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v6, "Digite temperatura em Celsius: "

    invoke-virtual {v5, v6}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 14
    invoke-virtual {v4}, Ljava/util/Scanner;->nextDouble()D

    move-result-wide v0

    .line 15
    .local v0, "cel":D
    const-wide/high16 v6, 0x4022000000000000L    # 9.0

    mul-double/2addr v6, v0

    const-wide/high16 v8, 0x4064000000000000L    # 160.0

    add-double/2addr v6, v8

    const-wide/high16 v8, 0x4014000000000000L    # 5.0

    div-double v2, v6, v8

    .line 16
    .local v2, "far":D
    return-void
.end method
