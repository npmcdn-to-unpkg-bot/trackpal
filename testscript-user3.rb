require 'net/http'

# get coords from Google Earth app, 'create path', right click on path and 'copy', paste into empty document
coords = [[151.1844197859218,-33.90351670479617],
[151.1848138476419,-33.90291870982015],
[151.1848221999682,-33.90221485792516],
[151.1851271065202,-33.90162132635046],
[151.1854315527281,-33.90083947989334],
[151.1857304536518,-33.90005658290419],
[151.1858907248202,-33.89962159814085],
[151.1861109482108,-33.89899306753502],
[151.1865669729033,-33.89850406617413],
[151.1867658820636,-33.89809998671979],
[151.1872916138452,-33.89747992919452],
[151.1877514864125,-33.89691445901458],
[151.1885033091393,-33.89661813226881],
[151.1888316166583,-33.89632334455082],
[151.1894830096267,-33.89613256154994],
[151.1899740784213,-33.89586526863933],
[151.1903369715418,-33.89566868150917],
[151.1906026192952,-33.89523897859599],
[151.1912831486511,-33.8951278891801],
[151.1924306432798,-33.89464681023994],
[151.1933780084581,-33.89443393323967],
[151.1941577069264,-33.89400070393921],
[151.1953590217785,-33.89372586702905],
[151.1958125164332,-33.89342408325666],
[151.1966264508563,-33.89315335382081],
[151.197246199355,-33.89259391979274],
[151.197929215611,-33.8922722572748],
[151.1987741502265,-33.89187055086871],
[151.1993595715543,-33.89158863777889],
[151.1997496551186,-33.8909905868507],
[151.2003677519691,-33.89061151530237],
[151.2007891714314,-33.8902127958206],
[151.2009844901921,-33.88947834534918],
[151.2014367073825,-33.88884079667785],
[151.202185394101,-33.88805183926694],
[151.2031989444557,-33.88763302216385],
[151.203622948789,-33.88706767667735],
[151.2039468501355,-33.88666386370259],
[151.2044000635285,-33.88596314846995],
[151.2046929610895,-33.8854484065786],
[151.2050506942391,-33.88474432630964],
[151.2055057035627,-33.88393242289812],
[151.2061236208492,-33.88320175346637],
[151.2074923626091,-33.88306478506416],
[151.2078519124608,-33.88254817543235],
[151.2082092118299,-33.88211566679364],
[151.2085515709547,-33.88147074743574],
[151.2084473031667,-33.88109402652162],
[151.2079924884281,-33.88084909776713],
[151.2074153694994,-33.88043462376834],
[151.2073827103843,-33.87991795299867],
[151.2074122017011,-33.87907789197341],
[151.2073442241482,-33.87850970447187],
[151.2075334291634,-33.87781096650661],
[151.2076256234497,-33.87743780379368],
[151.2076885477735,-33.87681667815529],
[151.207682460892,-33.87603855029174],
[151.2077409622638,-33.87547938792223],
[151.207834993805,-33.87483500047215],
[151.2081889617895,-33.87435488977612],
[151.2086425043364,-33.87376138272114],
[151.2088382711775,-33.87338185343337],
[151.2091305936897,-33.87313859885365],
[151.2093911735239,-33.87243455279754],
[151.2095868862612,-33.87194667213789],
[151.2099454817811,-33.8713500806755],
[151.2102391663684,-33.87080741577711],
[151.2107518011673,-33.87051895886692],
[151.2101035695439,-33.87006262034806],
[151.2097136301909,-33.86973790528381],
[151.2095221426856,-33.86916582582693],
[151.209394206137,-33.86883834156082]
]

# users.each do ....

coords.each do |c|
  uri = URI('http://localhost:3000/submit_position')  # your url
  params = { lat: c[1], lng: c[0], group_id: 68, user_id: 114 }
  uri.query = URI.encode_www_form(params)
  p uri
  res = Net::HTTP.get_response(uri)
  #### puts res.body if res.is_a?(Net::HTTPSuccess)

  sleep 2
end

# end users.each
