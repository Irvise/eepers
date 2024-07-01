with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Interfaces.C.Pointers;
with Raymath; use Raymath;
with Ada.Unchecked_Conversion;

package Raylib is
   
   -- note: some older versions of GNAT don't have C_bool, so we are defining ours
   type C_Bool is private;
   --  type Addr is private;
   type Addr is mod 2 ** Standard'Address_Size;

   type Color_Integer is mod 2**32
     with Size => 32;
   type Vector2_Array is array (Natural range <>) of aliased Vector2;

   subtype Int_8 is Natural range 0 .. 255;
   type Color is record
      r: Int_8;
      g: Int_8;
      b: Int_8;
      a: Int_8;
   end record;
   type C_Color is private;

   type Camera2D is record
      offset: Vector2;
      target: Vector2;
      rotation: Float;
      zoom: Float;
   end record;
   type C_Camera2D is private;
   
   type Texture2D is record
      Id: Natural;
      Width: Integer;
      Height: Integer;
      Mipmaps: Integer;
      Format: Integer;
   end record;
   type C_Texture2D is private;
   
   type Font is record
      Base_Size: Integer;
      Glyph_Count: Integer;
      Glyph_Padding: Integer;
      Texture: aliased Texture2D;
      Rects: Addr;
      Glyph_Info: Addr;
   end record;
   type C_Font is private;
   
   type Image is record
      Data: Addr;
      Width: Integer;
      Height: Integer;
      Mipmaps: Integer;
      Format: Integer;
   end record;
   type C_Image is private;
   
   type Audio_Stream is record
      Buffer: Addr;
      Processor: Addr;
      Sample_Rate: Natural;
      Sample_Size: Natural;
      Channels: Natural;
   end record;
   type C_Audio_Stream is private;

   type Sound is record
      Stream: Audio_Stream;
      Frame_Count: Natural;
   end record;
   type C_Sound is private;

   type Music is record
      Stream: Audio_Stream;
      Frame_Count: Natural;
      Looping: Boolean;
      Ctx_Type: Integer;
      Ctx_Data: Addr;
   end record;
   type C_Music is private;
 
   type Color_Array is array (Natural range <>) of aliased Color;

   --  package Color_Pointer is new Interfaces.C.Pointers(
   --    Index => Natural,
   --    Element => Raylib.Color,
   --    Element_Array => Color_Array,
   --    Default_Terminator => (others => 0));
   --  function To_Color_Pointer is new Ada.Unchecked_Conversion (Addr, Color_Pointer.Pointer);

   procedure Init_Window(Width, Height: Integer; Title: in String);
   procedure Close_Window
     with
     Import => True,
     Convention => C,
     External_Name => "CloseWindow";
   
   function Window_Should_Close return Boolean;

   procedure Begin_Drawing
     with
     Import => True,
     Convention => C,
     External_Name => "BeginDrawing";
   procedure End_Drawing
     with
     Import => True,
     Convention => C,
     External_Name => "EndDrawing";
   procedure Clear_Background(c: Color);
   procedure Draw_Rectangle(posX, posY, Width, Height: Integer; c: Color)
     with Inline;
   function Get_Screen_Width return Integer;
   function Get_Screen_Height return Integer;
   
   procedure Set_Config_Flags(flags: Natural);
   
   FLAG_WINDOW_RESIZABLE: constant Natural := 16#00000004#;
   KEY_NULL:   constant Integer := 0;
   KEY_C:      constant Integer := 67;
   KEY_R:      constant Integer := 82;
   KEY_S:      constant Integer := 83;
   KEY_W:      constant Integer := 87;
   KEY_A:      constant Integer := 65;
   KEY_D:      constant Integer := 68;
   KEY_P:      constant Integer := 80;
   KEY_O:      constant Integer := 79;
   KEY_X:      constant Integer := 88;
   KEY_RIGHT:  constant Integer := 262;
   KEY_LEFT:   constant Integer := 263;
   KEY_DOWN:   constant Integer := 264;
   KEY_UP:     constant Integer := 265;
   KEY_SPACE:  constant Integer := 32;
   KEY_ESCAPE: constant Integer := 256;
   KEY_ENTER:  constant Integer := 257;
   KEY_LEFT_SHIFT:  constant Integer := 340;
   KEY_RIGHT_SHIFT: constant Integer := 344;

   function Is_Key_Pressed(key: Integer) return Boolean;
   function Is_Key_Released(key: Integer) return Boolean;
   function Get_Key_Pressed return Integer;

   procedure Draw_Rectangle_V(position: Vector2; size: Vector2; c: Color)
     with Inline;

   procedure Begin_Mode2D(camera: Camera2D);
   procedure End_Mode2D;
   function Get_Frame_Time return Float
     with Inline;
   function Get_Color(hexValue: Color_Integer) return Color
     with Inline;
   function Color_To_Int(C: Color) return Natural
     with Inline;
   procedure Draw_Circle(centerX, centerY: Integer; radius: Float; c: Color)
     with Inline;
   procedure Draw_Circle_V(center: Vector2; radius: Float; C: Color)
     with Inline;
   function Is_Key_Down(Key: Integer) return Boolean
     with Inline;
   function Measure_Text(Text: String; FontSize: Integer) return Integer
     with Inline;
   procedure Draw_Text(Text: String; PosX, PosY: Integer; FontSize: Integer; C: Color)
     with Inline;
   procedure Draw_Text_Ex(F: Font; Text: String; Position: Vector2; Font_Size: Float; Spacing: Float; Tint: Color)
     with Inline;
   procedure Set_Target_FPS(Fps: Integer);
   procedure Draw_FPS(PosX, PosY: Integer)
     with Inline;
   function Color_Brightness(C: Color; Factor: Float) return Color;
   function Color_To_HSV(C: Color) return Vector3
     with Inline;
   function Color_From_HSV(Hue, Saturation, Value: Float) return Color
     with Inline;
   procedure Set_Exit_Key(Key: Integer);
   function Get_Time return Long_Float
     with Inline;
   function Load_Image(File_Name: String) return Image;
   function Gen_Image_Color(Width, Height: Integer; C: Color) return Image;
   function Export_Image(Img: Image; File_Name: String) return Boolean;
   procedure Draw_Triangle(V1, V2, V3: Vector2; C: Color)
     with Inline;
   procedure Draw_Triangle_Strip(Points: Vector2_Array; C: Color)
     with Inline;

   function Get_Working_Directory return String;
   function Get_Application_Directory return String;
   function Change_Directory(dir: String) return Boolean;
   
   function Load_Sound(File_Name: String) return Sound;
   function Load_Music_Stream(File_Name: String) return Music;
   procedure Play_Music_Stream(M: Music)
     with Inline;
   procedure Stop_Music_Stream(M: Music)
     with Inline;
   function Is_Music_Stream_Playing(M: Music) return Boolean;
   procedure Update_Music_Stream(M: Music);
   procedure Set_Music_Volume(M: Music; Volume: Float);
   procedure Init_Audio_Device;
   procedure Play_Sound(S: Sound)
     with Inline;
   procedure Set_Sound_Pitch(S: Sound; Pitch: Float);
   procedure Set_Sound_Volume(S: Sound; Volume: Float);
   procedure Set_Window_Icon(Img: Image);

   function Load_Font_Ex(File_Name: String; Font_Size: Integer; Codepoints: Addr; Codepoint_Count: Integer) return Font;
   function Measure_Text_Ex(F: Font; Text: String; Font_Size: Float; Spacing: Float) return Vector2;
   procedure Gen_Texture_Mipmaps(T: access Texture2D);
   
private
   
   -- note: some older versions of GNAT don't have C_bool, so we are defining ours
   type C_Bool is new Boolean
     with
     Convention => C;
   
   type C_Color is record
      r: Unsigned_Char;
      g: Unsigned_Char;
      b: Unsigned_Char;
      a: Unsigned_Char;
   end record
     with Convention => C_Pass_By_Copy;
   
   type C_Camera2D is record
      offset: Vector2;
      target: Vector2;
      rotation: C_float;
      zoom: C_float;
   end record
     with Convention => C_Pass_By_Copy;
   
   type C_Texture2D is record
      Id: unsigned;
      Width: int;
      Height: int;
      Mipmaps: int;
      Format: int;
   end record
     with Convention => C_Pass_By_Copy;

   type C_Font is record
      Base_Size: int;
      Glyph_Count: int;
      Glyph_Padding: int;
      Texture: aliased Texture2D;
      Rects: Addr;
      Glyph_Info: Addr;
   end record
     with Convention => C_Pass_By_Copy;
   
   type C_Image is record
      Data: Addr;
      Width: int;
      Height: int;
      Mipmaps: int;
      Format: int;
   end record
     with Convention => C_Pass_By_Copy;
   
   type C_Audio_Stream is record
      Buffer: Addr;
      Processor: Addr;
      Sample_Rate: unsigned;
      Sample_Size: unsigned;
      Channels: unsigned;
   end record
     with Convention => C_Pass_By_Copy;

   type C_Sound is record
      Stream: Audio_Stream;
      Frame_Count: unsigned;
   end record
     with Convention => C_Pass_By_Copy;

   type C_Music is record
      Stream: Audio_Stream;
      Frame_Count: unsigned;
      Looping: C_Bool;
      Ctx_Type: Int;
      Ctx_Data: Addr;
   end record
     with Convention => C_Pass_By_Copy;
   
end Raylib;
