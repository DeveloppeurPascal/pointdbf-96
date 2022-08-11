unit PP_PasswordDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TPPPasswordDlgUsage = (pduConnect, pduConnectAndChange, pduChange);
    // pduConnect = pour demander la saisie du mot de passe et de l'utilisateur
    // pduChange = pour demander la modification d'un mot de passe
    // pduConnectAndChange = pour demander l'utilisateur et son mot de passe et
    //                       permettre la modif du mot de passe

  TOnCodePasswordEvent = function (User, Password : string) : string of object;
    // pour obtenir le mot de passe après encodage selon l'algorithme de
    // l'utilisateur

  TOnGetPasswordEvent = function (User : string) : string of object;
    // Pour récupérer le mot de passe qui a été stocké par l'application

  TOnSetPasswordEvent = function (User, NewPassword : string) : boolean of object;
    // Pour modifier le mot de passe et le signaler à l'application

  TPPPasswordDlgLength = 1..128;

  TPPPasswordDlg = class(TComponent)
  private
    FOnCodePassword: TOnCodePasswordEvent;
    FOnGetPassword: TOnGetPasswordEvent;
    FOnSetPassword: TOnSetPasswordEvent;

    FPasswordLength : TPPPasswordDlgLength;
    FUsage : TPPPasswordDlgUsage;
    FTitle : string;
    FUserLength : TPPPasswordDlgLength;
    FDefaultUser : string;
  protected
  public
    constructor Create (AOwner: TComponent); override;
    function Execute : boolean;
  published
    { Les propriétés... }
    property PasswordLength : TPPPasswordDlgLength read FPasswordLength write FPasswordLength default 10;
    property Usage : TPPPasswordDlgUsage read FUsage write FUsage default pduConnect;
    property Title : string read FTitle write FTitle;
    property UserLength : TPPPasswordDlgLength read FUserLength write FUserLength default 10;
    property DefaultUser: string read FDefaultUser write FDefaultUser;

    {Les évènements }
    property OnCodePassword : TOnCodePasswordEvent read FOnCodePassword write FOnCodePassword;
    property OnGetPassword : TOnGetPasswordEvent read FOnGetPassword write FOnGetPassword;
    property OnSetPassword : TOnSetPasswordEvent read FOnSetPassword write FOnSetPassword;
  end;

procedure Register;

implementation

uses
    PP_PasswordDlgForm;

procedure Register;
begin
  RegisterComponents('pprem', [TPPPasswordDlg]);
end;

constructor TPPPasswordDlg.Create (AOwner: TComponent);
begin
  Usage := pduConnect;
  UserLength := 10;
  PasswordLength := 10;
  inherited Create (AOwner);
end;

function TPPPasswordDlg.Execute : boolean;
var
   fiche : TPPPasswordDlgForm;
begin
  fiche := TPPPasswordDlgForm.Create (nil);
  try
    fiche.edt_User.MaxLength := UserLength;
    fiche.edt_Password.MaxLength := PasswordLength;
    fiche.edt_NewPassword.MaxLength := PasswordLength;
    fiche.edt_NewPasswordConfirm.MaxLength := PasswordLength;
    fiche.Usage := Usage;
    fiche.Caption := Title;
    fiche.DefaultUser := DefaultUser;
    fiche.OnCodePassword := OnCodePassword;
    fiche.OnSetPassword := OnSetPassword;
    fiche.OnGetPassword := OnGetPassword;
    Result := (Fiche.ShowModal = mrOk);
  finally
    fiche.Free;
  end;
end;

end.
