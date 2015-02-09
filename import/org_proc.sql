delimiter \\
drop procedure if exists del_org_descendants\\
create procedure del_org_descendants(
	IN org_name varchar(100), 
	IN com_id varchar(100), 
	IN del_self boolean
)
begin
	declare org_code_deleted varchar(100);
    
    select o.id into org_code_deleted from mdm_org o where o.name = org_name;
    if org_code_deleted is not null
    then
        create temporary table org_descendants 
        as 
			select descendant_code from mdm_org_tree_path t 
            where 
				t.ancestor_code = org_code_deleted 
			and t.ancestor_code <> t.descendant_code;
        set autocommit=0;    
        -- delete descendants
        delete from mdm_org where id in (select * from org_descendants) and com_id = com_id;
        delete from mdm_org_tree_path where descendant_code in (select * from org_descendants) and com_id = com_id;
        
        -- delete self
        if del_self
        then
            delete from mdm_org  where id = org_code_deleted;
            delete from mdm_org_tree_path where len = 0 and descdent_code = org_code_deleted;
        end if;
        commit ;
        set autocommit=1;    
    end if;
end\\
drop procedure if exists create_org_new\\
create procedure create_org_new(
	IN abbreviation_name varchar(100),
    IN full_name varchar(100),
    IN parent_full_name varchar(100),
    IN com_id varchar(100)
)
begin
	declare parent_org_code varchar(100);
    
    -- get org_code of parent org
	SELECT 
		org.org_code_real
	INTO parent_org_code FROM
		mdm_org org
	WHERE
		org.name = parent_full_name
			AND org.com_id = com_id;
	
    if parent_org_code is not null
    then
		call create_org(abbreviation_name, com_id, NULL, full_name, REPLACE(UUID(), '-', ''), parent_org_code);
	else
		select concat("WARN:","No org found for [org_name", parent_full_name, "]");
    end if;
	
end \\
delimiter ;
