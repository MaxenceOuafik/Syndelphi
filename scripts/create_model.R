library(DiagrammeR)
DiagrammeR::mermaid("
flowchart LR
subgraph A[Being exposed to socio-economic disadvantages]
    1[Deprivation]
    2[Migration]
    3[School dropout]
    4[Unemployment]
    end

subgraph B[Facing mental health challenges]
    direction LR
    subgraph B1[Externalizing symptoms]
    6[Hostility]
    7[Substance use]
    8[Substance abuse]
        end
    subgraph B2[Internalizing symptoms]
        direction TB
        subgraph B2a[Self-esteem]
    18[Low self-esteem]
    19[Lack of assertiveness]
            end
    9[Anxiety]
    10[Burnout]
    11[Depression]
    12[Dysphoria]
    13[Emotional instability]
    14[PTSD]
        end
    subgraph B3[Minority Stress]
    15[Anticipation of negative events]
    16[Dissimulation of one's identity]
    17[Internalized homophobia]
        end
    5(Suicide attempts)
    end

subgraph C[Facing sexual health challenge]
    20[Cancer]
    21[STI]
    22[Sexual risk behaviors]
    23[HIV]
    end

subgraph S [Structural and social determinants]
    subgraph D[Navigating harmful social dynamics inside the community]
    direction LR
    24[Hypersexualization]
    25[Troubles bonding with other MSM]
    26[Struggles between romantic/sexual partners]
    27[Intracommunity stigma]
    28[Unhealthy power dynamics]
    end
    subgraph E[Struggling in a normative society]
    direction LR
        subgraph E1[Barriers to wellbeing]
    29[Barriers to physical activity]
    30[Barriers to STI screening]
    31[Poor healthcare access]
            end
        subgraph E2[Discrimination]
    32[Ageism]
    33[Homophobia]
    34[Transphobia]
            end
        subgraph E3[Lack of knowledge]
    35[Lack of knowledge in harm reduction]
    36[Misconceptions surrounding transidentity]
            end
        subgraph E4[Lack of social support]
    37[Loneliness]
    38[Poor family relationships]
    39[Unsupportive environment]
            end
        subgraph E5[Normative pressure]
    40[Cisnormativity]
    41[Heteronormativity]
    42[Patriarchal pressures on masculinity]
            end
    43[Lack of representation/role model]
    44[Violence]
        end
    end

S --> A 
S --> B 
S --> C 
"
)
