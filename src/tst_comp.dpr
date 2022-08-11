// tst_comp.dpr

// le source du projet de test du composant
program tst_comp;

uses
  Forms,
  tstu_comp in 'tstu_comp.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
