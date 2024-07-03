package body Raylib is

    begin

    end;
    
    
    procedure Init_Window(Width, Height: int; Title: in char_array) is
       procedure Init_Window(Width, Height: int; Title: in char_array)
         with
         Import => True,
         Convention => C,
         External_Name => "InitWindow";
    begin
       return Init_Window(To_C(Width), To_C(Height), To_C(Title));
    end;
    
   function Window_Should_Close return Boolean is
      function Window_Should_Close return C_Bool
        with
        Import => True,
        Convention => C,
        External_Name => "WindowShouldClose";
   begin
      return Boolean(Window_Should_Close);
   end;
   
   procedure Clear_Background(c: Color) is
      procedure Clear_Background(c: Color)
        with
        Import => True,
        Convention => C,
        External_Name => "ClearBackground";
   begin
      return To_Ada(Clear_Background(To_C(Color)));
   end;
   
   procedure Draw_Rectangle(posX, posY, Width, Height: int; c: Color)
        with
        Import => True,
        Convention => C,
        External_Name => "DrawRectangle";
   function Get_Screen_Width return int
     with
     Import => True,
     Convention => C,
     External_Name => "GetScreenWidth";
   function Get_Screen_Height return int
     with
     Import => True,
     Convention => C,
     External_Name => "GetScreenHeight";
   procedure Set_Config_Flags(flags: unsigned)
     with
     Import => True,
     Convention => C,
     External_Name => "SetConfigFlags";
   function Is_Key_Pressed(key: int) return bool
     with
     Import => True,
     Convention => C,
     External_Name => "IsKeyPressed";
   function Is_Key_Released(key: int) return bool
     with
     Import => True,
     Convention => C,
     External_Name => "IsKeyReleased";
   function Get_Key_Pressed return int
     with
     Import => True,
     Convention => C,
     External_Name => "GetKeyPressed";

   procedure Draw_Rectangle_V(position: Vector2; size: Vector2; c: Color)
     with
     Import => True,
     Convention => C,
     External_Name => "DrawRectangleV";

   procedure Begin_Mode2D(camera: Camera2D)
     with
     Import => True,
     Convention => C,
     External_Name => "BeginMode2D";
   procedure End_Mode2D
     with
     Import => True,
     Convention => C,
     External_Name => "EndMode2D";
   function Get_Frame_Time return C_float
     with
     Import => True,
     Convention => C,
     External_Name => "GetFrameTime";
   function Get_Color(hexValue: unsigned) return Color
     with
     Import => True,
     Convention => C,
     External_Name => "GetColor";
   function Color_To_Int(C: Color) return unsigned
     with
     Import => True,
     Convention => C,
     External_Name => "ColorToInt";
   procedure Draw_Circle(centerX, centerY: int; radius: C_float; c: Color)
     with
     Import => True,
     Convention => C,
     External_Name => "DrawCircle";
   procedure Draw_Circle_V(center: Vector2; radius: C_float; C: Color)
     with
     Import => True,
     Convention => C,
     External_Name => "DrawCircleV";
   function Is_Key_Down(Key: int) return Bool
     with
     Import => True,
     Convention => C,
     External_Name => "IsKeyDown";
   function Measure_Text(Text: Char_Array; FontSize: Int) return Int
     with
     Import => True,
     Convention => C,
     External_Name => "MeasureText";
   procedure Draw_Text(Text: Char_Array; PosX, PosY: Int; FontSize: Int; C: Color)
     with
     Import => True,
     Convention => C,
     External_Name => "DrawText";

   procedure Draw_Text_Ex(F: Font; Text: Char_Array; Position: Vector2; Font_Size: C_Float; Spacing: C_Float; Tint: Color)
     with
     Import => True,
     Convention => C,
     External_Name => "DrawTextEx";
   procedure Set_Target_FPS(Fps: int)
     with
     Import => True,
     Convention => C,
     External_Name => "SetTargetFPS";
   procedure Draw_FPS(PosX, PosY: Int)
     with
     Import => True,
     Convention => C,
     External_Name => "DrawFPS";
   function Color_Brightness(C: Color; Factor: C_Float) return Color
     with
     Import => True,
     Convention => C,
     External_Name => "ColorBrightness";
   function Color_To_HSV(C: Color) return Vector3
     with
     Import => True,
     Convention => C,
     External_Name => "ColorToHSV";
   function Color_From_HSV(Hue, Saturation, Value: C_Float) return Color
     with
     Import => True,
     Convention => C,
     External_Name => "ColorFromHSV";
   procedure Set_Exit_Key(Key: Int)
     with
     Import => True,
     Convention => C,
     External_Name => "SetExitKey";
   function Get_Time return Double
     with
     Import => True,
     Convention => C,
     External_Name => "GetTime";
   function Load_Image(File_Name: Char_Array) return Image
     with
     Import => True,
     Convention => C,
     External_Name => "LoadImage";
   function Gen_Image_Color(Width, Height: Int; C: Color) return Image
     with
     Import => True,
     Convention => C,
     External_Name => "GenImageColor";
   function Export_Image(Img: Image; File_Name: Char_Array) return Bool
     with
     Import => True,
     Convention => C,
     External_Name => "ExportImage";
   procedure Draw_Triangle(V1, V2, V3: Vector2; C: Color)
     with
     Import => True,
     Convention => C,
     External_Name => "DrawTriangle";

   function Get_Working_Directory return chars_ptr
     with
     Import => True,
     Convention => C,
     External_Name => "GetWorkingDirectory";
   function Get_Application_Directory return chars_ptr
     with
     Import => True,
     Convention => C,
     External_Name => "GetApplicationDirectory";
   function Change_Directory(dir: chars_ptr) return Bool
     with
     Import => True,
     Convention => C,
     External_Name => "ChangeDirectory";

   function Load_Sound(File_Name: char_array) return Sound
     with
     Import => True,
     Convention => C,
     External_Name => "LoadSound";
   function Load_Music_Stream(File_Name: char_array) return Music
     with
     Import => True,
     Convention => C,
     External_Name => "LoadMusicStream";
   procedure Play_Music_Stream(M: Music)
     with
     Import => True,
     Convention => C,
     External_Name => "PlayMusicStream";
   procedure Stop_Music_Stream(M: Music)
     with
     Import => True,
     Convention => C,
     External_Name => "StopMusicStream";
   function Is_Music_Stream_Playing(M: Music) return Bool
     with
     Import => True,
     Convention => C,
     External_Name => "IsMusicStreamPlaying";
   procedure Update_Music_Stream(M: Music)
     with
     Import => True,
     Convention => C,
     External_Name => "UpdateMusicStream";
   procedure Set_Music_Volume(M: Music; Volume: C_Float)
     with
     Import => True,
     Convention => C,
     External_Name => "SetMusicVolume";
   procedure Init_Audio_Device
     with
     Import => True,
     Convention => C,
     External_Name => "InitAudioDevice";
   procedure Play_Sound(S: Sound)
     with
     Import => True,
     Convention => C,
     External_Name => "PlaySound";
   procedure Set_Sound_Pitch(S: Sound; Pitch: C_Float)
     with
     Import => True,
     Convention => C,
     External_Name => "SetSoundPitch";
   procedure Set_Sound_Volume(S: Sound; Volume: C_Float)
     with
     Import => True,
     Convention => C,
     External_Name => "SetSoundVolume";
   procedure Set_Window_Icon(Img: Image)
     with
     Import => True,
     Convention => C,
     External_Name => "SetWindowIcon";

   function Load_Font_Ex(File_Name: char_array; Font_Size: int; Codepoints: Addr; Codepoint_Count: Integer) return Font
     with
     Import => True,
     Convention => C,
     External_Name => "LoadFontEx";
   function Measure_Text_Ex(F: Font; Text: Char_Array; Font_Size: C_Float; Spacing: C_Float) return Vector2
     with
     Import => True,
     Convention => C,
     External_Name => "MeasureTextEx";
   procedure Gen_Texture_Mipmaps(T: access Texture2D)
     with
     Import => True,
     Convention => C,
     External_Name => "GenTextureMipmaps";

end Raylib;
