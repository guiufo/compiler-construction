.class public Lcom/hello/android/hello/Teste1_9;
.super Ljava/lang/Object;
.source "Teste1_9.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .registers 4
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 7
    const/4 v0, 0x1

    .line 9
    .local v0, "n":I
    const/4 v1, 0x1

    if-ne v0, v1, :cond_a

    .line 10
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->print(I)V

    .line 15
    :goto_9
    return-void

    .line 13
    :cond_a
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->print(I)V

    goto :goto_9
.end method
