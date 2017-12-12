.class public LNano06;

.super Ljava/lang/Object;

.method public static main([Ljava/lang/String;)V
    .registers 4

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;
    const/16 v1, 1
    const/16 v2, 2
    sub-int v3, v1, v2
    invoke-virtual {v0, v3}, Ljava/io/PrintStream;->println(I)V

    return-void
.end method
