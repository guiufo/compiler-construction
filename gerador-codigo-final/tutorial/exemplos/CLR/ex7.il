.assembly extern mscorlib {}
.assembly 'ex7' {}

.module ex7.exe


  .class private auto ansi beforefieldinit ex7
  	extends [mscorlib]System.Object
  {
    .field  private static  int32 a
    .field  private static  int32 b
    .field  private static  int32 soma

    .method public hidebysig specialname rtspecialname 
           instance default void '.ctor' ()  cil managed 
    {
	// Code size 7 (0x7)
	.maxstack 8
	ldarg.0 
	call instance void object::'.ctor'()
	ret 
    }

    .method private static hidebysig 
           default int32 somador (int32 x, int32 y, int32 z)  cil managed 
    {
	// Code size 12 (0xc)
	.maxstack 3
	.locals init (
		int32	V_0, // r
		int32	V_1) // m
	ldc.i4.1 
	stloc.1 
	ldloc.1 
	ldarg.0 
	ldarg.1 
	add 
	ldarg.2 
	add 
	mul 
	stloc.0 
	ldloc.0 
	ret 
    } // end of method ex7::somador

    .method private static hidebysig 
           default void Main ()  cil managed 
    {
	.entrypoint
	// Code size 68 (0x44)
	.maxstack 3
	ldc.i4.2 
	stsfld int32 ex7::a
	ldc.i4.3 
	stsfld int32 ex7::b
	ldsfld int32 ex7::a
	ldc.i4.1 
	add 
	ldsfld int32 ex7::b
	ldc.i4.2 
	add 
	ldc.i4.5 
	call int32 class ex7::somador(int32, int32, int32)
	stsfld int32 ex7::soma
	ldsfld int32 ex7::a
	call void class [mscorlib]System.Console::WriteLine(int32)
	ldsfld int32 ex7::b
	call void class [mscorlib]System.Console::WriteLine(int32)
	ldsfld int32 ex7::soma
	call void class [mscorlib]System.Console::WriteLine(int32)
	ret 
    } // end of method ex7::Main

  } // end of class ex7

