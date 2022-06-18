program MinecraftServerPinger;
uses crt, System.Net;
var t, ip, apiurl: string;
var port: integer;
begin
  WriteLn('Minecraft Server Pinger');
  WriteLn('Version: 1.0, GitHub of creator: @ArsArsArsArs');
  WriteLn('[ • ] Enter version type (Java (J) or Bedrock (B))');
  try
    ReadLn(t);
  except
    textcolor(red);
    WriteLn('[ ! ] Something went wrong while entering');
    Exit;
  end;
  repeat
    t:=LowerCase(t);
    if (t = 'b') or (t = 'bedrock') then t:='bedrock' else begin
    if (t = 'j') or (t = 'java') then t:='java' else begin
        textcolor(red);
        WriteLn('[ ! ] Your version type must be "Java" or "Bedrock". Try again.');
        ReadLn(t);
        end;
    end;
  until (t = 'b') or (t = 'bedrock') or (t = 'j') or (t = 'java');
  textcolor(7);
  WriteLn('[ • ] Enter IP');
  try
    ReadLn(ip);
  except
    textcolor(red);
    WriteLn('[ ! ] Something went wrong while entering');
    Exit;
  end;
  textcolor(7);
  WriteLn('[ • ] Last step! Enter port');
  try
    ReadLn(port);
  except
    textcolor(red);
    WriteLn('[ ! ] Something went wrong while entering');
    textcolor(yellow);
    WriteLn('Did you write port correctly? It must be integer');
    textcolor(red);
    Exit;
  end;
  textcolor(7);
  WriteLn('Checking...');
  WriteLn('IP: ', ip, ', port: ', port);
  if t = 'bedrock' then apiurl:='https://api.mcsrvstat.us/bedrock/simple/'+ip+':'+port else apiurl:='https://api.mcsrvstat.us/simple/'+ip+':'+port;
  textcolor(7); 
  try
    ServicePointManager.SecurityProtocol := SecurityProtocolType.Tls12;
    var ServerRequest : HttpWebRequest:=HttpWebRequest(WebRequest.Create(apiurl));
    ServerRequest.Method := 'GET';
    var ServerResponse : WebResponse:=ServerRequest.GetResponse();
    textcolor(green);
    WriteLn(ip, ':', port, ' - Online!');
  except
    textcolor(LightRed);
    WriteLn(ip, ':', port, ' - Offilne / 404');
  end;
end.