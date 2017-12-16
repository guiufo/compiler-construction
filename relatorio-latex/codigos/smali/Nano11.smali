.class public LNano11;
.super Ljava/lang/Object;

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
    if-le v2, v1, :cond_c

    .line 12
    add-int/2addr v1, v0

    .line 13
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v3, v1}, Ljava/io/PrintStream;->print(I)V

    goto :goto_3

    .line 15
    :cond_c
    return-void
.end method
