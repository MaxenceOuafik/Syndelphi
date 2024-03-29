library(tidyverse)

wave2_data_cis <- wave2_data |>
    select(1:45) |>
    na.omit() |>
    rename("Dépression" = `Q21C.SQ001.`,
            "Mésusage d'alcool" = `Q21C.SQ006.`,
            "Compulsivité sexuelle" = `Q21C.SQ005.`,
            "Anxiété" = `Q21C.SQ002.`,
            "Comportements et/ou tentatives de suicide" = `Q21C.SQ003.`,
            "Problèmes d'usage de substance" = `Q21C.SQ008.`,
            "Homophobie internalisée" = `Q21C.SQ007.`,
            "PTSD" = `Q21C.SQ004.`,
            "Faible estime de soi" = `Q21C.SQ011.`,
            "IST" = `Q21C.SQ024.`,
            "VIH" = `Q21C.SQ025.`,
            "Subordination involontaire" = `Q21C.SQ010.`,
            "Usage de substance" = `Q21C.SQ019.`,
            "Violence entre partenaires" = `Q21C.SQ020.`,
            "Abus sexuels dans l'enfance" = `Q21C.SQ023.`,
            "Polyconsommation" = `Q21C.SQ026.`,
            "Binge drinking" = `Q21C.SQ021.`,
            "Comportements sexuels à risque" = `Q21C.SQ028.`,
            "Usage d'alcool" = `Q21C.SQ027.`,
            "Violence" = `Q21C.SQ029.`,
            "Homophobie" = `Q21C.SQ030.`,
            "Âgisme" = `Q21C.SQ031.`,
            "Chemsex" = `Q21C.SQ032.`,
            "Solitude" = `Q21C.SQ033.`,
            "Incarcération" = `Q21C.SQ034.`,
            "Problèmes de logement" = `Q21C.SQ035.`,
            "Usage de tabac" = `Q21C.SQ036.`,
            "Abus dans l'enfance" = `Q21C.SQ037.`,
            "Faible soutien social" = `Q21C.SQ038.`,
            "Précarité" = `Q21C.SQ039.`,
            "Chômage" = `Q21C.SQ040.`,
            "Cancers" = `Q21C.SQ041.`,
            "Difficultés liées à la migration" = `Q21C.SQ042.`,
            "Hétéronormativité" = `Q21C.SQ043.`,
            "Transphobie" = `Q21C.SQ044.`,
            "Dynamiques de pouvoir intra-communautaires" = `Q21C.SQ045.`,
            "Déscolarisation" = `Q21C.SQ046.`,
            "Accès à la PrEP" = `Q21C.SQ047.`,
            "Difficulté à accéder à des soins" = `Q21C.SQ048.`,
            "Instabilité émotionnelle" = `Q21C.SQ049.`,
            "Dissimulation de l'identité" = `Q21C.SQ050.`,
            "Difficultés dans la formation de l'identité" = `Q21C.SQ051.`,
            "Burnout" = `Q21C.SQ052.`,
            "Pressions patriarcales sur la masculinité" = `Q21C.SQ053.`,
            "Hypersexualisation intra-communautaire" = `Q21C.SQ054.`)

wave2_data_trans <- wave2_data |>
    select(46:92) |>
    na.omit() |> 
    rename("Dépression" = `Q21T.SQ001.`,
            "Mésusage d'alcool" = `Q21T.SQ006.`,
            "Compulsivité sexuelle" = `Q21T.SQ005.`,
            "Anxiété" = `Q21T.SQ002.`,
            "Comportements et/ou tentatives de suicide" = `Q21T.SQ003.`,
            "Problèmes d'usage de substance" = `Q21T.SQ008.`,
            "Homophobie internalisée" = `Q21T.SQ007.`,
            "PTSD" = `Q21T.SQ004.`,
            "Faible estime de soi" = `Q21T.SQ011.`,
            "IST" = `Q21T.SQ024.`,
            "VIH" = `Q21T.SQ025.`,
            "Subordination involontaire" = `Q21T.SQ010.`,
            "Usage de substance" = `Q21T.SQ019.`,
            "Violence entre partenaires" = `Q21T.SQ020.`,
            "Abus sexuels dans l'enfance" = `Q21T.SQ023.`,
            "Polyconsommation" = `Q21T.SQ026.`,
            "Binge drinking" = `Q21T.SQ021.`,
            "Comportements sexuels à risque" = `Q21T.SQ028.`,
            "Usage d'alcool" = `Q21T.SQ027.`,
            "Violence" = `Q21T.SQ029.`,
            "Homophobie" = `Q21T.SQ030.`,
            "Âgisme" = `Q21T.SQ031.`,
            "Chemsex" = `Q21T.SQ032.`,
            "Solitude" = `Q21T.SQ033.`,
            "Incarcération" = `Q21T.SQ034.`,
            "Problèmes de logement" = `Q21T.SQ035.`,
            "Usage de tabac" = `Q21T.SQ036.`,
            "Abus dans l'enfance" = `Q21T.SQ037.`,
            "Faible soutien social" = `Q21T.SQ038.`,
            "Précarité" = `Q21T.SQ039.`,
            "Chômage" = `Q21T.SQ040.`,
            "Cancers" = `Q21T.SQ041.`,
            "Difficultés liées à la migration" = `Q21T.SQ042.`,
            "Hétéronormativité" = `Q21T.SQ043.`,
            "Transphobie" = `Q21T.SQ044.`,
            "Dynamiques de pouvoir intra-communautaires" = `Q21T.SQ045.`,
            "Difficulté à accéder à des soins" = `Q21T.SQ048.`,
            "Dissimulation de l'identité" = `Q21T.SQ050.`,
            "Transphobie internalisée" = `Q21T.SQ054.`,
            "Cisnormativité" = `Q21T.SQ055.`,
            "Difficultés à pratiquer un sport" = `Q21T.SQ056.`,
            "Non-reconnaissance de l'identité (deadname, mégenrage)" = `Q21T.SQ057.`,
            "Méconnaissance sur les transidentités ; incompréhension" = `Q21T.SQ058.`,
            "Manque d'assertivité" = `Q21T.SQ059.`,
            "Dysphorie" = `Q21T.SQ060.`,
            "Pressions patriarcales sur la masculinité" = `Q21T.SQ061.`,
            "Hypersexualisation intra-communautaire" = `Q21T.SQ062.`)

wave2_data_cis_en <- wave2_data |>
    select(1:45) |>
    na.omit() |>
    rename("Depression" = `Q21C.SQ001.`,
            "Alcohol use disorder" = `Q21C.SQ006.`,
            "Sexual compulsivity" = `Q21C.SQ005.`,
            "Anxiety" = `Q21C.SQ002.`,
            "Suicidality" = `Q21C.SQ003.`,
            "Substance use disorder" = `Q21C.SQ008.`,
            "Internalised homophobia" = `Q21C.SQ007.`,
            "PTSD" = `Q21C.SQ004.`,
            "Low self esteem" = `Q21C.SQ011.`,
            "STI" = `Q21C.SQ024.`,
            "HIV" = `Q21C.SQ025.`,
            "Involuntary subordination" = `Q21C.SQ010.`,
            "Substance use" = `Q21C.SQ019.`,
            "IPV" = `Q21C.SQ020.`,
            "Childhood sexual abuse" = `Q21C.SQ023.`,
            "Polydrug use" = `Q21C.SQ026.`,
            "Binge drinking" = `Q21C.SQ021.`,
            "Risky sexual behaviours" = `Q21C.SQ028.`,
            "Alcohol use" = `Q21C.SQ027.`,
            "Violence" = `Q21C.SQ029.`,
            "Homophobia" = `Q21C.SQ030.`,
            "Ageism" = `Q21C.SQ031.`,
            "Chemsex" = `Q21C.SQ032.`,
            "Loneliness" = `Q21C.SQ033.`,
            "Incarceration" = `Q21C.SQ034.`,
            "Unstable housing" = `Q21C.SQ035.`,
            "Tobacco use" = `Q21C.SQ036.`,
            "Childhood abuse" = `Q21C.SQ037.`,
            "Low social support" = `Q21C.SQ038.`,
            "Deprivation" = `Q21C.SQ039.`,
            "Unemployment" = `Q21C.SQ040.`,
            "Cancers" = `Q21C.SQ041.`,
            "Migration" = `Q21C.SQ042.`,
            "Heteronormativity" = `Q21C.SQ043.`,
            "Transphobia" = `Q21C.SQ044.`,
            "Power dynamics" = `Q21C.SQ045.`,
            "Deschooling" = `Q21C.SQ046.`,
            "Access to PrEP" = `Q21C.SQ047.`,
            "Poor healthcare access" = `Q21C.SQ048.`,
            "Emotional instability" = `Q21C.SQ049.`,
            "Dissimulation" = `Q21C.SQ050.`,
            "Identity" = `Q21C.SQ051.`,
            "Burnout" = `Q21C.SQ052.`,
            "Pressures on masculinity" = `Q21C.SQ053.`,
            "Hypersexualisation" = `Q21C.SQ054.`)

wave2_data_trans_en <- wave2_data |>
    select(46:92) |>
    na.omit() |> 
    rename("Depression" = `Q21T.SQ001.`,
            "Alcohol use disorder" = `Q21T.SQ006.`,
            "Sexual compulsivity" = `Q21T.SQ005.`,
            "Anxiety" = `Q21T.SQ002.`,
            "Suicidality" = `Q21T.SQ003.`,
            "Substance use disorder" = `Q21T.SQ008.`,
            "Internalised homophobia" = `Q21T.SQ007.`,
            "PTSD" = `Q21T.SQ004.`,
            "Low self esteem" = `Q21T.SQ011.`,
            "STI" = `Q21T.SQ024.`,
            "HIV" = `Q21T.SQ025.`,
            "Involuntary subordination" = `Q21T.SQ010.`,
            "Substance use" = `Q21T.SQ019.`,
            "IPV" = `Q21T.SQ020.`,
            "Childhood sexual abuse" = `Q21T.SQ023.`,
            "Polydrug use" = `Q21T.SQ026.`,
            "Binge drinking" = `Q21T.SQ021.`,
            "Risky sexual behaviours" = `Q21T.SQ028.`,
            "Alcohol use" = `Q21T.SQ027.`,
            "Violence" = `Q21T.SQ029.`,
            "Homophobia" = `Q21T.SQ030.`,
            "Ageism" = `Q21T.SQ031.`,
            "Chemsex" = `Q21T.SQ032.`,
            "Loneliness" = `Q21T.SQ033.`,
            "Incarceration" = `Q21T.SQ034.`,
            "Unstable housing" = `Q21T.SQ035.`,
            "Tobacco use" = `Q21T.SQ036.`,
            "Childhood abuse" = `Q21T.SQ037.`,
            "Low social support" = `Q21T.SQ038.`,
            "Deprivation" = `Q21T.SQ039.`,
            "Unemployment" = `Q21T.SQ040.`,
            "Cancers" = `Q21T.SQ041.`,
            "Migration" = `Q21T.SQ042.`,
            "Heteronormativity" = `Q21T.SQ043.`,
            "Transphobia" = `Q21T.SQ044.`,
            "Power dynamics" = `Q21T.SQ045.`,
            "Poor healthcare access" = `Q21T.SQ048.`,
            "Dissimulation" = `Q21T.SQ050.`,
            "Internalised transphobia" = `Q21T.SQ054.`,
            "Cisnormativity" = `Q21T.SQ055.`,
            "Access to sports" = `Q21T.SQ056.`,
            "Identity denial" = `Q21T.SQ057.`,
            "Lack of knowledge" = `Q21T.SQ058.`,
            "Lack of assertivity" = `Q21T.SQ059.`,
            "Dysphoria" = `Q21T.SQ060.`,
            "Pressures on masuclinity" = `Q21T.SQ061.`,
            "Hypersexualisation" = `Q21T.SQ062.`)