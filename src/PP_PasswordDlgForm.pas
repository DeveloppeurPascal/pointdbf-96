// PP_PasswordDlgForm.pas

// source de la fiche servant de fenêtre de dialogue

unit PP_PasswordDlgForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, PP_PasswordDlg;

type
  TPPPasswordDlgStatus = (pdsAskPassword, pdsChangePassword);

  TPPPasswordDlgForm = class(TForm)
    Pnl_User: TPanel;
    Pnl_Password: TPanel;
    Pnl_NewPassword: TPanel;
    Pnl_Buttons: TPanel;
    btn_Ok: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_ChangePassword: TBitBtn;
    lbl_User: TLabel;
    edt_User: TEdit;
    lbl_Password: TLabel;
    lbl_NewPassword: TLabel;
    lbl_NewPasswordConfirm: TLabel;
    edt_Password: TEdit;
    edt_NewPassword: TEdit;
    edt_NewPasswordConfirm: TEdit;
    lbl_NewPasswordConfirm2: TLabel;
    procedure FormPaint(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ChangePasswordClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FOnCodePassword: TOnCodePasswordEvent;
    FOnGetPassword: TOnGetPasswordEvent;
    FOnSetPassword: TOnSetPasswordEvent;

    FStatus : TPPPasswordDlgStatus;
    FUsage : TPPPasswordDlgUsage;
    FDefaultUser : string;

    procedure SetDefaultUser (Value: string);
    procedure SetStatus (Value : TPPPasswordDlgStatus);
    procedure SetUsage (Value : TPPPasswordDlgUsage);
  protected
    procedure ShowHidePanel (RefreshForm : boolean);
  public
    property Status : TPPPasswordDlgStatus read FStatus write SetStatus;
    property Usage : TPPPasswordDlgUsage read FUsage write SetUsage;
    property DefaultUser: string read FDefaultUser write SetDefaultUser;

    property OnCodePassword : TOnCodePasswordEvent read FOnCodePassword write FOnCodePassword;
    property OnGetPassword : TOnGetPasswordEvent read FOnGetPassword write FOnGetPassword;
    property OnSetPassword : TOnSetPasswordEvent read FOnSetPassword write FOnSetPassword;
  end;

var
  PPPasswordDlgForm: TPPPasswordDlgForm;

implementation

{$R *.DFM}

procedure TPPPasswordDlgForm.ShowHidePanel (RefreshForm : boolean);
begin
  case FStatus of
    pdsAskPassword:
      begin
        btn_ChangePassword.Visible := (Usage = pduConnectAndChange);
        pnl_NewPassword.Visible := False;
        edt_User.Enabled := (DefaultUser = '');
        if (edt_User.Enabled)
        then edt_User.SetFocus
        else edt_Password.SetFocus;
      end;
    pdsChangePassword:
      begin
        btn_ChangePassword.Visible := False;
        pnl_NewPassword.Visible := True;
        edt_User.Enabled := (edt_User.Text = '');
        if (edt_User.Enabled)
        then edt_User.SetFocus
        else edt_Password.SetFocus;
        {endif}
      end;
  end;
  if RefreshForm then refresh;
end;

procedure TPPPasswordDlgForm.FormPaint(Sender: TObject);
var
   HauteurFiche : integer;
   LargeurFiche : integer;
   LeftPasswordChange, LeftOk, LeftCancel : integer;
begin
  { Calcul de la hauteur de la partie client de la fenêtre }
  HauteurFiche := Pnl_Buttons.Height;
  if (Pnl_User.Visible) then Inc (HauteurFiche, Pnl_User.Height);
  if (Pnl_Password.Visible) then Inc (HauteurFiche, Pnl_Password.Height);
  if (Pnl_NewPassword.Visible) then Inc (HauteurFiche, Pnl_NewPassword.Height);

  { Pour éviter de boucler en réaffichage, on ne change la taille de la partie
  cliente que si elle est à changer... en effet, changer cette valeur provoque
  un réaffichage... donc l'appel de OnPaint !}
  if (HauteurFiche <> ClientHeight) then ClientHeight := HauteurFiche;

  { Calcul de la largeur de la fenêtre pour centrer les boutons }
  LargeurFiche := pnl_Buttons.Width - btn_Ok.Width - 4 - btn_Cancel.Width;
  if (btn_ChangePassword.Visible)
  then
    LargeurFiche := LargeurFiche - btn_ChangePassword.Width - 4;
  {endif}

  { Positionement des boutons en les séparant de 4 points }
    // comme ils sont positionnés les uns par rapport aux autres, si le bouton
    // btn_ChangePassword n'apparaît pas, il faut en annuler la largeur
  if (btn_ChangePassword.Visible)
  then
    begin
      LeftPasswordChange := LargeurFiche div 2;
      if (btn_ChangePassword.Left <> LeftPasswordChange)
      then
        btn_ChangePassword.Left := LeftPasswordChange;
      {endif}
    end
  else
    LeftPasswordChange := (LargeurFiche div 2) - 4 - btn_ChangePassword.Width;
  {endif}
  LeftOk := LeftPasswordChange + btn_ChangePassword.Width + 4 ;
  if (btn_Ok.Left <> LeftOk) then btn_Ok.Left := LeftOk;

  LeftCancel := LeftOk + btn_Ok.Width + 4;
  if (btn_Cancel.Left <> LeftCancel) then btn_Cancel.Left := LeftCancel;
end;

procedure TPPPasswordDlgForm.SetDefaultUser (Value : string);
begin
  if (Value <> DefaultUser)
  then
    begin
      edt_User.Enabled := (Value = '');
      FDefaultUser := Value;
      edt_User.Text := Value;
    end;
  {endif}
end;

procedure TPPPasswordDlgForm.SetUsage (Value : TPPPasswordDlgUsage);
begin
  if (Value <> FUsage)
  then
    begin
      FUsage := Value;
      if (FUsage = pduChange)
      then Status := pdsChangePassword
      else Status := pdsAskPassword;
    end;
  {endif}
end;

procedure TPPPasswordDlgForm.SetStatus (Value : TPPPasswordDlgStatus);
begin
  if (Value <> FStatus)
  then
    begin
      FStatus := Value;
      edt_Password.Text := '';
      if Visible then ShowHidePanel (true);
    end;
  {endif}
end;

procedure TPPPasswordDlgForm.btn_CancelClick(Sender: TObject);
begin
  if ((Usage = pduConnectAndChange) and (Status = pdsChangePassword))
  then // On passe en saisie du mot de passe... si on annule sa modif
    Status := pdsAskPassword
  else // on sort en annulant la saisie
    ModalResult := mrCancel;
  {endif}
end;

procedure TPPPasswordDlgForm.btn_ChangePasswordClick(Sender: TObject);
begin
  Status := pdsChangePassword;
end;

procedure TPPPasswordDlgForm.FormCreate(Sender: TObject);
begin
  // suppression des bordures des paneaux (utiles en conception mais pas à
  // l'utilisation
  pnl_User.BevelOuter := bvNone;
  pnl_Password.BevelOuter := bvNone;
  pnl_NewPassword.BevelOuter := bvNone;
  pnl_Buttons.BevelOuter := bvNone;

  // Positionnement des paneaux automatiquement en haut de fiche, l'un en
  // dessous de l'autre
  pnl_User.Align := alTop;
  pnl_Password.Align := alTop;
  pnl_NewPassword.Align := alTop;
  pnl_Buttons.Align := alTop;
end;

procedure TPPPasswordDlgForm.btn_OkClick(Sender: TObject);
var
   MotDePasseValide : boolean; // indique si le mot de passe saisi est correct
   PasswordCode, // contient le mot de passe saisi après codage
   Password : String; // contient le mot de passe valide
begin
  MotDePasseValide := False;

  // Le nom de l'utilisateur est en saisie obligatoire
  if edt_User.Enabled and (edt_User.Text = '')
  then
    begin
      ShowMessage ('Utilisateur obligatoire !');
      edt_User.SetFocus;
      exit;
    end;
  {endif}

  // Le mot de passe est en saisie obligatoire
  if edt_Password.Enabled and (edt_Password.Text = '')
  then
    begin
      ShowMessage ('Saisie obligatoire !');
      edt_Password.SetFocus;
      exit;
    end;
  {endif}

  // cryptage du mot de passe saisi
  if Assigned (OnCodePassword)
  then PasswordCode := OnCodePassword (edt_User.Text, edt_Password.Text)
  else PasswordCode := edt_Password.Text;
  {endif}

  // récupération du mot de passe actuel
  if Assigned (OnGetPassword)
  then Password := OnGetPassword (edt_User.Text)
  else Password := '';
  {endif}

  MotDePasseValide := (PasswordCode = Password);
  if not MotDePasseValide
  then
    begin
      ShowMessage ('Mot de passe invalide !');
      edt_Password.Text := '';
      edt_Password.SetFocus;
      exit;
    end;
  {endif}

  case Status of
    pdsChangePassword:
      begin
        if (edt_NewPassword.Text <> edt_NewPasswordConfirm.Text)
        then
          begin
            ShowMessage ('Erreur entre le nouveau mot de passe et sa resaisie !');
            edt_NewPassword.Text := '';
            edt_NewPasswordConfirm.Text := '';
            edt_NewPassword.SetFocus;
            exit;
          end;
        {endif}
        // On code le nouveau mot de passe...
        if assigned (OnCodePassword)
        then PasswordCode := OnCodePassword (edt_User.Text, edt_NewPassword.Text)
        else PasswordCode := edt_NewPassword.Text;
        // puis on demande à l'application de le auvegarder pour l'utilisateur
        // en cours
        if assigned (OnSetPassword)
        then
          if OnSetPassword (edt_User.Text, edt_NewPassword.Text)
          then ModalResult := mrOk
          else ModalResult := mrCancel
        else
          ModalResult := mrOk;
        {endif}
        // si on peut repasser en saisie du mot de passe, on essaie de le faire
        if (Usage = pduConnectAndChange)
        then
          begin
            Status := pdsAskPassword;
            ModalResult := 0; // Empèche de sortir de la fiche !
          end;
        {endif}
      end;
    pdsAskPassword:
      if MotDePasseValide then ModalResult := mrOk else ModalResult := mrCancel;
  end;
end;

procedure TPPPasswordDlgForm.FormShow(Sender: TObject);
begin
  ShowHidePanel (False);
end;

end.
