.class public L/Micro05;
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
    .registers 10
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 8
    const/4 v5, 0x0

    .line 9
    .local v5, "x":I
    const/4 v0, 0x0

    .line 10
    .local v0, "h":I
    const/4 v2, 0x0

    .line 11
    .local v2, "m":I
    new-instance v1, Ljava/util/Scanner;

    sget-object v6, Ljava/lang/System;->in:Ljava/io/InputStream;

    invoke-direct {v1, v6}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 12
    .local v1, "leitor":Ljava/util/Scanner;
    new-instance v3, Ljava/lang/String;

    invoke-direct {v3}, Ljava/lang/String;-><init>()V

    .line 13
    .local v3, "nome":Ljava/lang/String;
    new-instance v4, Ljava/lang/String;

    invoke-direct {v4}, Ljava/lang/String;-><init>()V

    .line 15
    .local v4, "sexo":Ljava/lang/String;
    const/4 v5, 0x1

    :goto_15
    const/4 v6, 0x5

    if-gt v5, v6, :cond_5d

    .line 17
    sget-object v6, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v7, "Digite o nome: "

    invoke-virtual {v6, v7}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 18
    invoke-virtual {v1}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v3

    .line 19
    sget-object v6, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v7, "Homem(H) ou Mulher(M)?"

    invoke-virtual {v6, v7}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 20
    invoke-virtual {v1}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v4

    .line 22
    const/4 v6, -0x1

    invoke-virtual {v4}, Ljava/lang/String;->hashCode()I

    move-result v7

    sparse-switch v7, :sswitch_data_9a

    :cond_36
    :goto_36
    packed-switch v6, :pswitch_data_a4

    .line 30
    sget-object v6, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v7, "Homem(H) ou Mulher(M)!"

    invoke-virtual {v6, v7}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 15
    :goto_40
    add-int/lit8 v5, v5, 0x1

    goto :goto_15

    .line 22
    :sswitch_43
    const-string v7, "H"

    invoke-virtual {v4, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_36

    const/4 v6, 0x0

    goto :goto_36

    :sswitch_4d
    const-string v7, "M"

    invoke-virtual {v4, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_36

    const/4 v6, 0x1

    goto :goto_36

    .line 24
    :pswitch_57
    add-int/lit8 v0, v0, 0x1

    .line 25
    goto :goto_40

    .line 27
    :pswitch_5a
    add-int/lit8 v2, v2, 0x1

    .line 28
    goto :goto_40

    .line 35
    :cond_5d
    sget-object v6, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Foram inseridos "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " homens"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 36
    sget-object v6, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Foram inseridos "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " mulheres"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 37
    return-void

    .line 22
    :sswitch_data_9a
    .sparse-switch
        0x48 -> :sswitch_43
        0x4d -> :sswitch_4d
    .end sparse-switch

    :pswitch_data_a4
    .packed-switch 0x0
        :pswitch_57
        :pswitch_5a
    .end packed-switch
.end method
