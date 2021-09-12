-- For test
use Academy

select 
G.Id,
G.[Group name], 
G.[Year], 
G.FK_DepartmentId, 
L.Id, 
L.Classroom, 
L.FK_SubjectId, 
L.FK_TeacherId, 
GL.FK_GroupId, 
GL.FK_LectureId
from  
Academy.dbo.Groups as G, 
Academy.dbo.Lectures as L, 
Academy.dbo.[Groups and Lectures] AS GL
where G.Id=GL.FK_GroupId AND L.Id=GL.FK_LectureId