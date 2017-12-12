.class public Lcom/hello/android/hello/Nano10;
.super Ljava/lang/Object;
.source "Nano10.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .registers 5
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 6
    const/4 v0, 0x1

    .line 7
    .local v0, "numero1":I
    const/4 v1, 0x2

    .line 8
    .local v1, "numero2":I
    if-ne v0, v1, :cond_a

    .line 9
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v2, v0}, Ljava/io/PrintStream;->println(I)V

    .line 14
    :goto_9
    return-void

    .line 12
    :cond_a
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(I)V

    goto :goto_9
.end method
