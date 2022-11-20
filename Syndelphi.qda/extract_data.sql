-- CODES, CASENAMES AND CATEGORIES
SELECT code_name.name AS codename, code_cat.name AS categoryname, code_name.catid, code_cat.supercatid, cases.name AS casename
FROM code_text
JOIN code_name ON code_text.cid = code_name.cid
JOIN (case_text JOIN cases ON cases.caseid = case_text.caseid) ON code_text.fid = case_text.fid
JOIN code_cat ON code_name.catid = code_cat.catid 
WHERE (code_text.pos0 >= case_text.pos0 AND code_text.pos1 <= case_text.pos1)