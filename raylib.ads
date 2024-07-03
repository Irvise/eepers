private with Interfaces.C;
private with Interfaces.C.Strings;
-- with Interfaces.C.PoInters;
-- private with Raylib.Raymath; use Raylib.Raymath;
-- with Ada.Unchecked_Conversion;

package Raylib is

   ------------------------
   --  Type definitions  --
   ------------------------

   type Vector2 is record
      X : Float;
      Y : Float;
   end record;
   type C_Vector2 is private;

   type Vector3 is record
      X : Float;
      Y : Float;
      Z : Float;
   end record;
   type C_Vector3 is private;

   type Vector2_Array is array (Natural range <>) of Vector2;

   --  type Addr is private;
   type Addr is mod 2**Standard'Address_Size;

   type Color_Integer is mod 2**32 with
     Size => 32;

   type Unsigned_32 is mod 2**32 with
     Size => 32;

   subtype Int_8 is Natural range 0 .. 255;
   type Color is record
      R : Int_8;
      G : Int_8;
      B : Int_8;
      A : Int_8;
   end record;
   type C_Color is private;

   type Camera2D is record
      Offset   : Vector2;
      Target   : Vector2;
      Rotation : Float;
      Zoom     : Float;
   end record;
   type C_Camera2D is private;

   type Texture2D is record
      Id      : Natural;
      Width   : Integer;
      Height  : Integer;
      Mipmaps : Integer;
      Format  : Integer;
   end record;
   type C_Texture2D is private;

   type Font is record
      Base_Size     : Integer;
      Glyph_Count   : Integer;
      Glyph_Padding : Integer;
      Texture       : aliased Texture2D;
      Rects         : Addr;
      Glyph_Info    : Addr;
   end record;
   type C_Font is private;

   type Image is record
      Data    : Addr;
      Width   : Integer;
      Height  : Integer;
      Mipmaps : Integer;
      Format  : Integer;
   end record;
   type C_Image is private;

   type Audio_Stream is record
      Buffer      : Addr;
      Processor   : Addr;
      Sample_Rate : Natural;
      Sample_Size : Natural;
      Channels    : Natural;
   end record;
   type C_Audio_Stream is private;

   type Sound is record
      Stream      : Audio_Stream;
      Frame_Count : Natural; -- TODO, it may be better to make it a mod...
   end record;
   type C_Sound is private;

   type Music is record
      Stream      : Audio_Stream;
      Frame_Count : Natural; -- TODO, it may be better to make it a mod...
      Looping     : Boolean;
      Ctx_Type    : Integer;
      Ctx_Data    : Addr;
   end record;
   type C_Music is private;

   type Color_Array is array (Natural range <>) of Color;

   --  package Color_PoInter is new Interfaces.C.PoInters(
   --    Index => Natural,
   --    Element => Raylib.Color,
   --    Element_Array => Color_Array,
   --    Default_Terminator => (others => 0));
   --  function To_Color_PoInter is new Ada.Unchecked_Conversion (Addr, Color_PoInter.PoInter);

   ------------
   --  Data  --
   ------------

   FLAG_WINDOW_RESIZABLE : constant Unsigned_32 := 16#0000_0004#;
   KEY_NULL              : constant Integer     := 0;
   KEY_C                 : constant Integer     := 67;
   KEY_R                 : constant Integer     := 82;
   KEY_S                 : constant Integer     := 83;
   KEY_W                 : constant Integer     := 87;
   KEY_A                 : constant Integer     := 65;
   KEY_D                 : constant Integer     := 68;
   KEY_P                 : constant Integer     := 80;
   KEY_O                 : constant Integer     := 79;
   KEY_X                 : constant Integer     := 88;
   KEY_RIGHT             : constant Integer     := 262;
   KEY_LEFT              : constant Integer     := 263;
   KEY_DOWN              : constant Integer     := 264;
   KEY_UP                : constant Integer     := 265;
   KEY_SPACE             : constant Integer     := 32;
   KEY_ESCAPE            : constant Integer     := 256;
   KEY_ENTER             : constant Integer     := 257;
   KEY_LEFT_SHIFT        : constant Integer     := 340;
   KEY_RIGHT_SHIFT       : constant Integer     := 344;

   ------------------------
   --  Pubilc functions  --
   ------------------------

   procedure Init_Window
     (Width :    Integer := 640; Height : Integer := 320;
      Title : in String  := "My new Raylib Game");
   procedure Close_Window with
     Import => True, Convention => C, External_Name => "CloseWindow";

   function Window_Should_Close return Boolean;

   procedure Begin_Drawing with
     Import => True, Convention => C, External_Name => "BeginDrawing";
   procedure End_Drawing with
     Import => True, Convention => C, External_Name => "EndDrawing";
   procedure Clear_Background (C : Color);
   procedure Draw_Rectangle
     (Pos_X, Pos_Y : Integer; Width, Height : Natural; C : Color) with
     Inline;
   function Get_Screen_Width return Integer;
   function Get_Screen_Height return Integer;

   procedure Set_Config_Flags (Flags : Unsigned_32);

   function Is_Key_Pressed (Key : Integer) return Boolean with
     Inline;
   function Is_Key_Released (Key : Integer) return Boolean with
     Inline;
   function Get_Key_Pressed return Integer with
     Inline;

   procedure Draw_Rectangle_V
     (Position : Vector2; Size : Vector2; C : Color) with
     Inline;

   procedure Begin_Mode2D (Camera : Camera2D);
   procedure End_Mode2D with
     Import => True, Convention => C, External_Name => "EndMode2D";
   function Get_Frame_Time return Float with
     Inline;
   function Get_Color (HexValue : Color_Integer) return Color with
     Inline;
   -- function Color_To_Int (C : Color) return Unsigned_32 with
   --   Inline;
   procedure Draw_Circle
     (Center_X, Center_Y : Integer; Radius : Float; C : Color) with
     Inline;
   procedure Draw_Circle_V (Center : Vector2; Radius : Float; C : Color) with
     Inline;
   function Is_Key_Down (Key : Integer) return Boolean with
     Inline;
   function Measure_Text
     (Text : String; FontSize : Integer) return Integer with
     Inline;
   procedure Draw_Text
     (Text : String; Pos_X, Pos_Y : Integer; FontSize : Integer;
      C    : Color) with
     Inline;
   procedure Draw_Text_Ex
     (F       : Font; Text : String; Position : Vector2; Font_Size : Float;
      Spacing : Float; Tint : Color) with
     Inline;
   procedure Set_Target_FPS (FPS : Integer);
   procedure Draw_FPS (Pos_X, Pos_Y : Integer) with
     Inline;
   function Color_Brightness (C : Color; Factor : Float) return Color;
   function Color_To_HSV (C : Color) return Vector3 with
     Inline;
   function Color_From_HSV (Hue, Saturation, Value : Float) return Color with
     Inline;
   procedure Set_Exit_Key (Key : Integer);
   function Get_Time return Long_Float with
     Inline;
   function Load_Image (File_Name : String) return Image;
   function Gen_Image_Color (Width, Height : Integer; C : Color) return Image;
   function Export_Image (Img : Image; File_Name : String) return Boolean;
   procedure Draw_Triangle (V1, V2, V3 : Vector2; C : Color) with
     Inline;
   procedure Draw_Triangle_Strip (Points : Vector2_Array; C : Color) with
     Inline;

   function Get_Working_Directory return String;
   function Get_Application_Directory return String;
   function Change_Directory (Dir : String) return Boolean;

   function Load_Sound (File_Name : String) return Sound;
   function Load_Music_Stream (File_Name : String) return Music;
   procedure Play_Music_Stream (M : Music) with
     Inline;
   procedure Stop_Music_Stream (M : Music) with
     Inline;
   function Is_Music_Stream_Playing (M : Music) return Boolean with
     Inline;
   procedure Update_Music_Stream (M : Music);
   procedure Set_Music_Volume (M : Music; Volume : Float);
   procedure Init_Audio_Device with
     Import => True, Convention => C, External_Name => "InitAudioDevice";
   procedure Play_Sound (S : Sound) with
     Inline;
   procedure Set_Sound_Pitch (S : Sound; Pitch : Float);
   procedure Set_Sound_Volume (S : Sound; Volume : Float);
   procedure Set_Window_Icon (Img : Image);

   function Load_Font_Ex
     (File_Name       : String; Font_Size : Integer; Codepoints : Addr;
      Codepoint_Count : Integer) return Font;
   function Measure_Text_Ex
     (F : Font; Text : String; Font_Size : Float; Spacing : Float)
      return Vector2;
   procedure Gen_Texture_Mipmaps (T : access Texture2D);

private

   use Interfaces.C;
   use Interfaces.C.Strings;

   ------------------------------------------
   --  C representation for the Ada types  --
   ------------------------------------------

   type C_Vector2 is record
      X : C_float;
      Y : C_float;
   end record with
     Convention => C_Pass_By_Copy;
   type C_Vector3 is record
      X : C_float;
      Y : C_float;
      Z : C_float;
   end record with
     Convention => C_Pass_By_Copy;

   type C_Color is record
      R : unsigned_char;
      G : unsigned_char;
      B : unsigned_char;
      A : unsigned_char;
   end record with
     Convention => C_Pass_By_Copy;

   type C_Camera2D is record
      Offset   : C_Vector2;
      Target   : C_Vector2;
      Rotation : C_float;
      Zoom     : C_float;
   end record with
     Convention => C_Pass_By_Copy;

   type C_Texture2D is record
      Id      : unsigned;
      Width   : int;
      Height  : int;
      Mipmaps : int;
      Format  : int;
   end record with
     Convention => C_Pass_By_Copy;

   type C_Font is record
      Base_Size     : int;
      Glyph_Count   : int;
      Glyph_Padding : int;
      Texture       : aliased C_Texture2D;
      Rects         : Addr;
      Glyph_Info    : Addr;
   end record with
     Convention => C_Pass_By_Copy;

   type C_Image is record
      Data    : Addr; -- TODO
      Width   : int;
      Height  : int;
      Mipmaps : int;
      Format  : int;
   end record with
     Convention => C_Pass_By_Copy;

   type C_Audio_Stream is record
      Buffer      : Addr; -- TODO
      Processor   : Addr; -- TODO
      Sample_Rate : unsigned;
      Sample_Size : unsigned;
      Channels    : unsigned;
   end record with
     Convention => C_Pass_By_Copy;

   type C_Sound is record
      Stream      : C_Audio_Stream;
      Frame_Count : unsigned;
   end record with
     Convention => C_Pass_By_Copy;

   type C_Music is record
      Stream      : C_Audio_Stream;
      Frame_Count : unsigned;
      Looping     : C_bool;
      Ctx_Type    : int;
      Ctx_Data    : Addr; -- TODO
   end record with
     Convention => C_Pass_By_Copy;

   ------------------------------
   --  Type casting functions  --
   ------------------------------

   function To_C (Vector : Vector2) return C_Vector2 is
     (X => C_float (Vector.X), Y => C_float (Vector.Y)) with
     Inline;

   function To_C (Vector : Vector3) return C_Vector3 is
     (X => C_float (Vector.X), Y => C_float (Vector.Y),
      Z => C_float (Vector.Z)) with
     Inline;

   function To_Ada (Vector : C_Vector2) return Vector2 is
     (X => Float (Vector.X), Y => Float (Vector.Y)) with
     Inline;

   function To_Ada (Vector : C_Vector3) return Vector3 is
     (X => Float (Vector.X), Y => Float (Vector.Y), Z => Float (Vector.Z)) with
     Inline;

   function To_C (C : Color) return C_Color is
     (R => unsigned_char (C.R), G => unsigned_char (C.G),
      B => unsigned_char (C.B), A => unsigned_char (C.A)) with
     Inline;

   function To_Ada (C : C_Color) return Color is
     (R => Int_8 (C.R), G => Int_8 (C.G), B => Int_8 (C.B),
      A => Int_8 (C.A)) with
     Inline;

   function To_C (C : Camera2D) return C_Camera2D is
     (Offset   => To_C (C.Offset), Target => To_C (C.Target),
      Rotation => C_float (C.Rotation), Zoom => C_float (C.Zoom)) with
     Inline;

   function To_Ada (C : C_Camera2D) return Camera2D is
     (Offset   => To_Ada (C.Offset), Target => To_Ada (C.Target),
      Rotation => Float (C.Rotation), Zoom => Float (C.Zoom)) with
     Inline;

   function To_C (T : Texture2D) return C_Texture2D is
     (Id => unsigned (T.Id), Width => int (T.Width), Height => int (T.Height),
      Mipmaps => int (T.Mipmaps), Format => int (T.Format)) with
     Inline;

   function To_Ada (T : C_Texture2D) return Texture2D is
     (Id     => Integer (T.Id), Width => Integer (T.Width),
      Height => Integer (T.Height), Mipmaps => Integer (T.Mipmaps),
      Format => Integer (T.Format)) with
     Inline;

   function To_C (Img : Image) return C_Image is
     (Data   => Addr (Img.Data), Width => int (Img.Width),
      Height => int (Img.Height), Mipmaps => int (Img.Mipmaps),
      Format => int (Img.Format)) with
     Inline;

   function To_Ada (Img : C_Image) return Image is
     (Data   => Addr (Img.Data), Width => Integer (Img.Width),
      Height => Integer (Img.Height), Mipmaps => Integer (Img.Mipmaps),
      Format => Integer (Img.Format)) with
     Inline;

   function To_C (S : Audio_Stream) return C_Audio_Stream is
     (Buffer      => Addr (S.Buffer), Processor => Addr (S.Processor),
      Sample_Rate => unsigned (S.Sample_Rate),
      Sample_Size => unsigned (S.Sample_Size),
      Channels    => unsigned (S.Channels)) with
     Inline;

   function To_Ada (S : C_Audio_Stream) return Audio_Stream is
     (Buffer      => Addr (S.Buffer), Processor => Addr (S.Processor),
      Sample_Rate => Natural (S.Sample_Rate),
      Sample_Size => Natural (S.Sample_Size),
      Channels    => Natural (S.Channels)) with
     Inline;

   function To_C (S : Sound) return C_Sound is
     (Stream => To_C (S.Stream), Frame_Count => unsigned (S.Frame_Count)) with
     Inline;

   function To_Ada (S : C_Sound) return Sound is
     (Stream => To_Ada (S.Stream), Frame_Count => Natural (S.Frame_Count)) with
     Inline;

   function To_Ada (M : C_Music) return Music is
     (Stream   => To_Ada (M.Stream), Frame_Count => Natural (M.Frame_Count),
      Looping  => Boolean (M.Looping), Ctx_Type => Integer (M.Ctx_Type),
      Ctx_Data => Addr (M.Ctx_Data)) with
     Inline;

   function To_C (M : Music) return C_Music is
     (Stream   => To_C (M.Stream), Frame_Count => unsigned (M.Frame_Count),
      Looping  => C_bool (M.Looping), Ctx_Type => int (M.Ctx_Type),
      Ctx_Data => Addr (M.Ctx_Data)) with
     Inline;

   -------------------------------
   --  Import Raylib functions  --
   -------------------------------

   procedure C_Draw_Triangle_Strip
     (Points : Vector2_Array; Point_Count : int;
      C      : C_Color) with -- TODO Fix array
     Import => True, Convention => C, External_Name => "DrawTriangleStrip";

   procedure C_Init_Window (Width, Height : int; Title : in char_array) with
     Import => True, Convention => C, External_Name => "InitWindow";

   function C_Window_Should_Close return C_bool with
     Import => True, Convention => C, External_Name => "WindowShouldClose";

   procedure Clear_Background (c : C_Color) with
     Import => True, Convention => C, External_Name => "ClearBackground";

   procedure Draw_Rectangle (posX, posY, Width, Height : int; c : C_Color) with
     Import => True, Convention => C, External_Name => "DrawRectangle";

   function C_Get_Screen_Width return int with
     Import => True, Convention => C, External_Name => "GetScreenWidth";
   function C_Get_Screen_Height return int with
     Import => True, Convention => C, External_Name => "GetScreenHeight";

   procedure Set_Config_Flags (flags : unsigned) with
     Import => True, Convention => C, External_Name => "SetConfigFlags";

   function Is_Key_Pressed (key : int) return C_bool with
     Import => True, Convention => C, External_Name => "IsKeyPressed";
   function Is_Key_Released (key : int) return C_bool with
     Import => True, Convention => C, External_Name => "IsKeyReleased";
   function C_Get_Key_Pressed return int with
     Import => True, Convention => C, External_Name => "GetKeyPressed";

   procedure Draw_Rectangle_V
     (position : C_Vector2; size : C_Vector2; c : C_Color) with
     Import => True, Convention => C, External_Name => "DrawRectangleV";

   procedure Begin_Mode2D (camera : C_Camera2D) with
     Import => True, Convention => C, External_Name => "BeginMode2D";
   function C_Get_Frame_Time return C_float with
     Import => True, Convention => C, External_Name => "GetFrameTime";
   function Get_Color (hexValue : unsigned) return C_Color with
     Import => True, Convention => C, External_Name => "GetColor";
   function Color_To_Int (C : Color) return unsigned with
     Import => True, Convention => C, External_Name => "ColorToInt";
   procedure Draw_Circle
     (centerX, centerY : int; radius : C_float; c : C_Color) with
     Import => True, Convention => C, External_Name => "DrawCircle";
   procedure Draw_Circle_V
     (center : C_Vector2; radius : C_float; C : C_Color) with
     Import => True, Convention => C, External_Name => "DrawCircleV";
   function Is_Key_Down (Key : int) return C_bool with
     Import => True, Convention => C, External_Name => "IsKeyDown";
   function Measure_Text (Text : char_array; FontSize : int) return int with
     Import => True, Convention => C, External_Name => "MeasureText";
   procedure Draw_Text
     (Text : char_array; PosX, PosY : int; FontSize : int; C : C_Color) with
     Import => True, Convention => C, External_Name => "DrawText";

   procedure Draw_Text_Ex
     (F : C_Font; Text : char_array; Position : Vector2; Font_Size : C_float;
      Spacing : C_float; TInt : C_Color) with
     Import => True, Convention => C, External_Name => "DrawTextEx";
   procedure Set_Target_FPS (Fps : int) with
     Import => True, Convention => C, External_Name => "SetTargetFPS";
   procedure Draw_FPS (PosX, PosY : int) with
     Import => True, Convention => C, External_Name => "DrawFPS";
   function Color_Brightness
     (C : C_Color; Factor : C_float) return C_Color with
     Import => True, Convention => C, External_Name => "ColorBrightness";
   function Color_To_HSV (C : C_Color) return C_Vector3 with
     Import => True, Convention => C, External_Name => "ColorToHSV";
   function Color_From_HSV
     (Hue, Saturation, Value : C_float) return C_Color with
     Import => True, Convention => C, External_Name => "ColorFromHSV";
   procedure Set_Exit_Key (Key : int) with
     Import => True, Convention => C, External_Name => "SetExitKey";
   function C_Get_Time return double with
     Import => True, Convention => C, External_Name => "GetTime";

   function Load_Image (File_Name : char_array) return C_Image with
     Import => True, Convention => C, External_Name => "LoadImage";
   function Gen_Image_Color
     (Width, Height : int; C : C_Color) return C_Image with
     Import => True, Convention => C, External_Name => "GenImageColor";
   function Export_Image
     (Img : C_Image; File_Name : char_array) return C_bool with
     Import => True, Convention => C, External_Name => "ExportImage";
   procedure Draw_Triangle (V1, V2, V3 : C_Vector2; C : C_Color) with
     Import => True, Convention => C, External_Name => "DrawTriangle";

   function C_Get_Working_Directory return chars_ptr with
     Import => True, Convention => C, External_Name => "GetWorkingDirectory";
   function C_Get_Application_Directory return chars_ptr with
     Import        => True, Convention => C,
     External_Name => "GetApplicationDirectory";
   function Change_Directory (dir : chars_ptr) return C_bool with
     Import => True, Convention => C, External_Name => "ChangeDirectory";

   function Load_Sound (File_Name : char_array) return C_Sound with
     Import => True, Convention => C, External_Name => "LoadSound";
   function Load_Music_Stream (File_Name : char_array) return C_Music with
     Import => True, Convention => C, External_Name => "LoadMusicStream";
   procedure Play_Music_Stream (M : C_Music) with
     Import => True, Convention => C, External_Name => "PlayMusicStream";
   procedure Stop_Music_Stream (M : C_Music) with
     Import => True, Convention => C, External_Name => "StopMusicStream";
   function Is_Music_Stream_Playing (M : C_Music) return C_bool with
     Import => True, Convention => C, External_Name => "IsMusicStreamPlaying";
   procedure Update_Music_Stream (M : C_Music) with
     Import => True, Convention => C, External_Name => "UpdateMusicStream";
   procedure Set_Music_Volume (M : C_Music; Volume : C_float) with
     Import => True, Convention => C, External_Name => "SetMusicVolume";
   procedure Play_Sound (S : C_Sound) with
     Import => True, Convention => C, External_Name => "PlaySound";
   procedure Set_Sound_Pitch (S : C_Sound; Pitch : C_float) with
     Import => True, Convention => C, External_Name => "SetSoundPitch";
   procedure Set_Sound_Volume (S : C_Sound; Volume : C_float) with
     Import => True, Convention => C, External_Name => "SetSoundVolume";
   procedure Set_Window_Icon (Img : C_Image) with
     Import => True, Convention => C, External_Name => "SetWindowIcon";

   function Load_Font_Ex
     (File_Name       : char_array; Font_Size : int; Codepoints : Addr;
      Codepoint_Count : Integer) return C_Font with
     Import => True, Convention => C, External_Name => "LoadFontEx";
   function Measure_Text_Ex
     (F : C_Font; Text : char_array; Font_Size : C_float; Spacing : C_float)
      return C_Vector2 with
     Import => True, Convention => C, External_Name => "MeasureTextEx";
   procedure Gen_Texture_Mipmaps (T : access C_Texture2D) with
     Import => True, Convention => C, External_Name => "GenTextureMipmaps";

   ----------------------------------------------------------
   --  Define Ada functions with their bodies/expressions  --
   ----------------------------------------------------------

   function Window_Should_Close return Boolean is
     (Boolean (C_Window_Should_Close));

   function Get_Screen_Width return Integer is (Integer (C_Get_Screen_Width));
   function Get_Screen_Height return Integer is
     (Integer (C_Get_Screen_Height));

   function Is_Key_Pressed (Key : Integer) return Boolean is
     (Boolean (Is_Key_Pressed (int (Key))));

   function Is_Key_Released (Key : Integer) return Boolean is
     (Boolean (Is_Key_Released (int (Key))));

   function Get_Key_Pressed return Integer is (Integer (C_Get_Key_Pressed));

   function Get_Frame_Time return Float is (Float (C_Get_Frame_Time));

   function Get_Color (HexValue : Color_Integer) return Color is
     (To_Ada (Get_Color (unsigned (HexValue))));

   function Is_Key_Down (Key : Integer) return Boolean is
     (Boolean (Is_Key_Down (int (Key))));

   function Measure_Text (Text : String; FontSize : Integer) return Integer is
     (Integer (Measure_Text (To_C (Text), int (FontSize))));

   function Color_Brightness (C : Color; Factor : Float) return Color is
     (To_Ada (Color_Brightness (To_C (C), C_float (Factor))));

   function Color_To_HSV (C : Color) return Vector3 is
     (To_Ada (Color_To_HSV (To_C (C))));

   function Color_From_HSV (Hue, Saturation, Value : Float) return Color is
     (To_Ada
        (Color_From_HSV
           (C_float (Hue), C_float (Saturation), C_float (Value))));

   function Get_Time return Long_Float is (Long_Float (C_Get_Time));

   function Load_Image (File_Name : String) return Image is
     (To_Ada (Load_Image (To_C (File_Name))));

   function Gen_Image_Color
     (Width, Height : Integer; C : Color) return Image is
     (To_Ada (Gen_Image_Color (int (Width), int (Height), To_C (C))));

   function Export_Image (Img : Image; File_Name : String) return Boolean is
     (Boolean (Export_Image (To_C (Img), To_C (File_Name))));

   function Get_Working_Directory return String is
     (Value (C_Get_Working_Directory));

   function Get_Application_Directory return String is
     (Value (C_Get_Application_Directory));

   function Change_Directory (Dir : String) return Boolean is
     (Boolean (Change_Directory (New_String (Dir))));

   function Load_Sound (File_Name : String) return Sound is
     (To_Ada (Load_Sound (To_C (File_Name))));

   function Load_Music_Stream (File_Name : String) return Music is
     (To_Ada (Load_Music_Stream (To_C (File_Name))));

   function Is_Music_Stream_Playing (M : Music) return Boolean is
     (Boolean (Is_Music_Stream_Playing (To_C (M))));
   
   --  function Color_To_Int (C : Color) return Unsigned_32 is
   --     (); -- TODO
end Raylib;
