library(data.table)
library(googleVis)
library(cld2)
library(tidytext)
library(dplyr)
library(stringr)



Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

beer_words <- data_frame(word=c("head", "beer", "aroma", "taste", "body", "pours", "flavour", "bottle", "notes"), lexicon="BEER")

stop_words_beer <- bind_rows(stop_words, beer_words)



df_cervezas  <- readRDS("/media/Datos/Data_science/Mis proyectos/RB_Final/auxi/df_cervezas2")
df_revisiones <- readRDS("/media/Datos/Data_science/Mis proyectos/RB_Final/auxi/df_revisiones2")
df_brewers <- readRDS("/media/Datos/Data_science/Mis proyectos/RB_Final/Data/dfbrewers")

cerve2 <- df_cervezas[df_brewers, on="bre_id"]

cerve2[, repetido:=.N, by =cer_url]

cerve2 <- cerve2[cer_ncom>49 | (cer_ncom>49 & bre_pais=="Spain"), ]



cerve2 <- cerve2[leida == TRUE]

cerve2[, brew_media := mean(cer_score), by = bre_id]

cerve2[, industrial := (bre_tipo == "Commercial Brewery" & brew_media<2.75)]


cerve3 <- cerve2[, .(cer_id, brewer, seasonal, cer_name, cer_tipo, cer_score, cer_abv, cer_retired, bre_name, bre_pais, bre_logo_url, repetido, industrial, cer_f_ini)]

cerve3[, pais := bre_pais]
cerve3[bre_pais %in% c("England", "Gibraltar", "Guernsey", "Isle of Man", "Scotland", "Wales"), pais:= "United Kingdom"]
cerve3[bre_pais %in% c("Puerto Rico", "USA", "United States Virgin Islands"), pais := "United States"]
cerve3[bre_pais == "Macedonia", pais:= "Republic of Macedonia"]
cerve3[bre_pais == "Senegal Republic", pais:= "Senegal"]
cerve3[bre_pais == "Slovak Republic", pais:= "Slovakia"]

paises <- Population[, c(2,5)]
cerve2 <- merge(cerve3, paises, by.x="pais", by.y="Country")

cerve2 <- mutate(cerve2, tipo = case_when(str_detect(cer_tipo, "Englis|Bitte|Scotc| Brown") ~ "eng",
                                str_detect(cer_tipo, "Abbe|Belgi|Abt") ~  "bel", 
                                str_detect(cer_tipo, "Porte|Stout") ~  "sto",
                                str_detect(cer_tipo, "Wine|Old|rican St") ~  "baw",
                                str_detect(cer_tipo, "rican Pal|Amber|Golden") ~  "apa",
                                str_detect(cer_tipo, "Lambi|Berlin") ~  "lam",
                                str_detect(cer_tipo, "eizen|Wheat|Witbi") ~  "tri",
                                str_detect(cer_tipo, "Lager|Pils|bier|Okto") ~  "lag",
                                str_detect(cer_tipo, "Black") ~  "bip",
                                str_detect(cer_tipo, "Smoke") ~  "ahu",
                                str_detect(cer_tipo, "Fruit") ~  "fru",
                                str_detect(cer_tipo, "Vege") ~  "veg",
                                str_detect(cer_tipo, "India|IPA") ~  "ipa",
                                str_detect(cer_tipo, "Irish") ~  "iri",
                                str_detect(cer_tipo, "Doppe") ~  "dop",
                                str_detect(cer_tipo, "Low") ~  "low"
                                )) %>% 
          filter(!is.na(tipo))


revis <- df_revisiones[,head(.SD,60) ,cer_id]
revis[ , lang := detect_language(rev_texto)]
revis2 <- revis[lang == "en", .(cer_id, rev_id, rev_texto)]

revis2 <- revis2 %>% semi_join(cerve2) 

frases2 <- revis2 %>% unnest_tokens(sentence, rev_texto, token="sentences") 

#frases2<- sample_n(frases, 500000)

head <- frases2 %>% filter(str_detect(sentence, "head")) %>% 
  mutate(head = str_match(sentence, "(?:with|,) ([^,]*) head")[,2]) %>%  
  unnest_tokens(words, head, token = "words") %>% 
  mutate(head = case_when(words %in% c("small", "thin", "no", "tiny", "minimal", "light") ~ 1,
                                  words %in% c("medium", "decent", "finger", "good") ~ 2,
                                  words %in% c("huge", "big", "large") ~ 3,
                                  words %in% c("creamy", "frothy", "foamy", "fluffy") ~ 4,
                                  TRUE ~ 0))  %>% 
  filter(head != 0) %>% group_by(cer_id) %>%  
  summarise(head_m = Mode(head))

color <- frases2 %>% filter(str_detect(sentence, "colou?r|pour")) %>% 
  mutate(col1 = str_match(sentence, "pour(.*?)(with|,|\\.)")[,2],
         col2 = str_match(sentence, "(.*) colo")[,2],
         color = paste(col1, col2)) %>%  
  unnest_tokens(words, color, token = "words") %>% 
  group_by(cer_id, rev_id, words) %>% slice(1) %>%
  ungroup() %>% 
  mutate(color = case_when(words %in% c("golden", "amber", "yellow", "golden") ~ 1,
                          words %in% c("orange", "red", "reddish", "honey", "copper" ) ~ 2,
                          words %in% c("brown", "caramel") ~ 3,
                          words %in% c("dark", "black") ~ 4,
                          TRUE ~ 0))  %>% 
  filter(color != 0) %>% group_by(cer_id) %>%  
  summarise(color = Mode(color))


aroma <- frases2 %>% filter(str_detect(sentence, "aroma|nose|notes")) %>% 
  unnest_tokens(word, sentence, token = "words") %>% 
  anti_join(stop_words_beer)%>%
  mutate(malt = str_detect(word, "^malt.*|cereal|grain.*|barley|^rye"),
         pan = str_detect(word, "^bread.*"),
         caramel = str_detect(word, "caramel"),
         equilibrado = str_detect(word, "^balance.*"),
         sweet = str_detect(word, "sweet.*|^sugar"),
         citrico = str_detect(word, "^citr.*|^lemo.*|lime"),
         hops = str_detect(word, "^hop.*|ĥerba.*|^grass.*"),
         chocolate = str_detect(word, "chocola.*|cocoa"),
         frutal = str_detect(word, "^fru[it].*"),
         cafe = str_detect(word, "coffee|espres.*"),
         floral = str_detect(word, "flo[rw].*"),
         naranja = str_detect(word, "^orang.*|grapefrui.*|tangeri.*"),
         vanilla= str_detect(word, "^vanilla"),
         toffe = str_detect(word, "^toffe"),
         tostado = str_detect(word, "^roast.*|^toast"),
         alcohol = str_detect(word, "^alcoh.*|^booz.*"),
         pino = str_detect(word, "^pine[^a]?.*|resin.*"),
         miel = str_detect(word, "honey"),
         sirope = str_detect(word, "mapple.*|molasse.*|^syrup"),
         tropical = str_detect(word, "mango.*|papaya.*|passionfru.*|tropica.*"),
         pina = str_detect(word, "pineapple.*"),
         madera = str_detect(word, "^oak|^wood.*"),
         agua = str_detect(word, "^watery?$"),
         banana = str_detect(word, "banana.*"),
         cereza = str_detect(word, "^cherr.*"),
         manzana = str_detect(word, "apple.*"),
         especies = str_detect(word, "^spic.*"),
         tierra = str_detect(word, "^earth.*"),
         melocoton = str_detect(word, "^peach.*|aprico.*|^plum.*"),
         licor = str_detect(word, "bourbo.*|^whisk.*|brandy|cognac"),
         bacon = str_detect(word, "bacon.*"),
         nuez = str_detect(word, "^nut.*|chesnu.*|^peanu.*"),
         coco = str_detect(word, "coconu.*"),
         maiz = str_detect(word, "^corn$"), 
         metal = str_detect(word, "^metal.*"),
         humo = str_detect(word, "^smok.*|^tobac.*"),
         picante = str_detect(word, "^hot|^chil.*"),
         leche = str_detect(word, "^milk.*|lactose"),
         heno = str_detect(word, "^hay.*|^straw$|^leaf"),
         uva = str_detect(word, "^grape[^f]*"),
         tea = str_detect(word, "^tea$"),
         gum = str_detect(word, "^cand.*|gum"),
         melon = str_detect(word, "^melon.*"),
         pera = str_detect(word, "^pears?$"),
         fresa = str_detect(word, "^strawb"),
         cuero = str_detect(word, "^leathe"),
         soja = str_detect(word, "^soy"),
         mineral = str_detect(word, "^minera"),
         queso = str_detect(word, "^chees[ey]?$"),
         vino = str_detect(word, "^wine"),
         galleta = str_detect(word, "^biscu.*|^cook.*")) %>% 
  select(-rev_id, -word) %>% 
  group_by(cer_id) %>% 
  summarise_all(funs(a = sum))

sabor <- frases2 %>% filter(str_detect(sentence, "taste|flavour")) %>% 
  unnest_tokens(word, sentence, token = "words") %>%
  anti_join(stop_words_beer) %>% 
  mutate(malt = str_detect(word, "^malt.*|cereal|grain.*|barley|^rye"),
         pan = str_detect(word, "^bread.*"),
         caramel = str_detect(word, "caramel"),
         equilibrado = str_detect(word, "^balance.*"),
         sweet = str_detect(word, "sweet.*|^sugar"),
         citrico = str_detect(word, "^citr.*|^lemo.*|lime"),
         hops = str_detect(word, "^hop.*|ĥerba.*|^grass.*"),
         chocolate = str_detect(word, "chocola.*|cocoa"),
         frutal = str_detect(word, "^fru[it].*"),
         cafe = str_detect(word, "coffee|espres.*"),
         floral = str_detect(word, "flo[rw].*"),
         naranja = str_detect(word, "^orang.*|grapefrui.*|tangeri.*"),
         vanilla= str_detect(word, "^vanilla"),
         toffe = str_detect(word, "^toffe"),
         tostado = str_detect(word, "^roast.*|^toast"),
         alcohol = str_detect(word, "^alcoh.*|^booz.*"),
         pino = str_detect(word, "^pine[^a]?.*|resin.*"),
         miel = str_detect(word, "honey"),
         sirope = str_detect(word, "mapple.*|molasse.*|^syrup"),
         tropical = str_detect(word, "mango.*|papaya.*|passionfru.*|tropica.*"),
         pina = str_detect(word, "pineapple.*"),
         madera = str_detect(word, "^oak|^wood.*"),
         agua = str_detect(word, "^watery?$"),
         banana = str_detect(word, "banana.*"),
         cereza = str_detect(word, "^cherr.*"),
         manzana = str_detect(word, "apple.*"),
         especies = str_detect(word, "^spic.*"),
         tierra = str_detect(word, "^earth.*"),
         melocoton = str_detect(word, "^peach.*|aprico.*|^plum.*"),
         licor = str_detect(word, "bourbo.*|^whisk.*|brandy|cognac"),
         bacon = str_detect(word, "bacon.*"),
         nuez = str_detect(word, "^nut.*|chesnu.*|^peanu.*"),
         coco = str_detect(word, "coconu.*"),
         maiz = str_detect(word, "^corn$"), 
         metal = str_detect(word, "^metal.*"),
         humo = str_detect(word, "^smok.*|^tobac.*"),
         picante = str_detect(word, "^hot|^chil.*"),
         leche = str_detect(word, "^milk.*|lactose"),
         heno = str_detect(word, "^hay.*|^straw$|^leaf"),
         uva = str_detect(word, "^grape[^f]*"),
         tea = str_detect(word, "^tea$"),
         gum = str_detect(word, "^cand.*|gum"),
         melon = str_detect(word, "^melon.*"),
         pera = str_detect(word, "^pears?$"),
         fresa = str_detect(word, "^strawb"),
         cuero = str_detect(word, "^leathe"),
         soja = str_detect(word, "^soy"),
         queso = str_detect(word, "^chees[ey]?$"),
         vino = str_detect(word, "^wine"),
         mineral = str_detect(word, "^minera"),
         galleta = str_detect(word, "^biscu.*|^cook.*")) %>% 
  select(-rev_id, -word) %>% 
  group_by(cer_id) %>% 
  summarise_all(funs(s = sum)) 
  
  #%>% 
  #  para sacar las variables usar comillas simples ' 
  # str_match_all(text, '"(.*).png')[[1]][,2]->tex 
  #saveRDS(tex, "tex")

         
final <- inner_join(cerve2, head) %>% 
         inner_join(color) %>% 
         inner_join(aroma) %>% 
         inner_join(sabor) %>% 
         mutate(Flag = str_match(Flag, '\\"(.*)\\"')[, 2]) %>% 
         mutate(mod_est = ifelse(str_detect(cer_tipo, "Sessio"), 1, ifelse(str_detect(cer_tipo, "Imperia"), 2,0))) %>% 
         mutate(puntu = case_when (
           cer_score < 1.5 ~ 1,
           cer_score < 2 ~ 2,
           cer_score < 2.5 ~ 3,
           cer_score < 3 ~ 4,
           cer_score < 3.5 ~ 5,
           cer_score < 3.75 ~ 6,
           cer_score < 4 ~ 7,
           TRUE ~ 8 )) %>% 
        mutate(alco = case_when (
           cer_abv < 2 ~ 1,
           cer_abv < 5 ~ 2,
           cer_abv < 7.5 ~ 3,
           cer_abv < 10 ~ 4,
           cer_abv < 12.5 ~ 5,
           cer_abv < 100 ~ 6,
           TRUE ~ 7))  

saveRDS(final, "final")


?sulibrary(httr)
library(rvest)
html_session("https://res.cloudinary.com/ratebeer/image/upload/w_150,h_150,c_limit/brew_32870.jpg")
