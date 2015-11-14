require(tidyr)
require(dplyr)
require(tm)
require(wordcloud)
require(RCurl)
require(plyr)
require(ggplot2)

Traffic <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from ROAD_ACCIDENT"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_tl23642', PASS='orcl_tl23642', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

Air <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from AIR6"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_tl23642', PASS='orcl_tl23642', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

LeftJoin <- dplyr::left_join(Traffic, Air, by=c("DATE_"="END_DATE"))

scatt = ddply(
  LeftJoin,
  .(NUMBER_OF_CASUALTIES, NO2,PM10),
)

ggplot(scatt, aes(y=NO2, x=NUMBER_OF_CASUALTIES, size = PM10)) + geom_point(shape=1, color = "blue")
