.class public Lcom/hello/android/hello/Nano08;
.super Ljava/lang/Object;
.source "Nano08.java"


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
    .line 6
    const/4 v0, 0x1

    .line 7
    .local v0, "numero":I
    const/4 v1, 0x1

    if-ne v0, v1, :cond_a

    .line 8
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(I)V

    .line 13
    :goto_9
    return-void

    .line 11
    :cond_a
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(I)V

    goto :goto_9
.end method
