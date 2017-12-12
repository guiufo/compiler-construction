.class public Lcom/hello/android/hello/Nano12;
.super Ljava/lang/Object;
.source "Nano12.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .registers 6
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 7
    const/4 v1, 0x1

    .line 8
    .local v1, "n":I
    const/4 v0, 0x2

    .line 9
    .local v0, "m":I
    const/4 v2, 0x5

    .line 11
    .local v2, "x":I
    :goto_3
    if-le v2, v1, :cond_16

    .line 12
    if-ne v1, v0, :cond_f

    .line 13
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v3, v1}, Ljava/io/PrintStream;->print(I)V

    .line 19
    :goto_c
    add-int/lit8 v2, v2, -0x1

    goto :goto_3

    .line 17
    :cond_f
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Ljava/io/PrintStream;->print(I)V

    goto :goto_c

    .line 21
    :cond_16
    return-void
.end method
