.class public LMicro06;
.super Ljava/lang/Object;
.source "Micro06.java"

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
    const/4 v1, 0x0

    .line 9
    .local v1, "n":I
    new-instance v0, Ljava/util/Scanner;

    sget-object v2, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v0, v2}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 11
    .local v0, "leitor":Ljava/util/Scanner;
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Digite um n\u00famero de 1 a 5: "

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 13
    packed-switch v1, :pswitch_data_42

    .line 30
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "N\u00famero inv\u00e1lido."

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 33
    :goto_19
    return-void

    .line 15
    :pswitch_1a
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Um"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_19

    .line 18
    :pswitch_22
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Dois"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_19

    .line 21
    :pswitch_2a
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Tr\u00eas"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_19

    .line 24
    :pswitch_32
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Quatro"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_19

    .line 27
    :pswitch_3a
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Cinco"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_19

    .line 13
    :pswitch_data_42
    .packed-switch 0x1
        :pswitch_1a
        :pswitch_22
        :pswitch_2a
        :pswitch_32
        :pswitch_3a
    .end packed-switch
.end method
