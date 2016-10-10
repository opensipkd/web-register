-- tgl-11-09-2016
alter table units add status smallint;
update units set status=1;

alter table rekenings add status smallint;
update rekenings set status=1;

alter table subjekpajaks rename to wajibpajaks;
alter table objekpajaks alter column rename subjek_pajak_id to wajibpajak_id ;

alter table objekpajaks drop column unit_id cascade;

alter table artbp add column terutang bigint;

update artbp set penambah=0;
update artbp set pengurang=0;
update artbp set terutang=0;

alter table arinvoices rename subjek_pajak_id to wajibpajak_id ;
alter table arinvoices rename objek_pajak_id to objekpajak_id ;

alter table arinvoices add penambah bigint not null default 0;
alter table arinvoices add pengurang bigint not null default 0;
alter table arinvoices add terutang bigint not null default 0;

update artbp set penambah=0;
update artbp set pengurang=0;
update artbp set terutang=0;

--wajib nambah wilayah
--wajib ngisi wp per skpd
--wajib ngisi op per skpd
--replace field wajib_pajak_id wajibpajak_id
--replace field objek_pajak_id objekpajak_id