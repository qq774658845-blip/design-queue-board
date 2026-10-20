-- 在 Supabase -> SQL Editor 运行。先将 qq774658845@gmail.com 替换为管理员登录邮箱。
create table if not exists public.design_requests (
 id bigint primary key,
 queue_order integer not null,
 owner text not null,
 task text not null,
 category text not null default '其他',
 status text not null default '排队中' check(status in ('排队中','制作中','待反馈','已完成')),
 submitted_date date not null default current_date,
 note text not null default '',
 created_at timestamptz not null default now()
);
alter table public.design_requests enable row level security;
drop policy if exists "Public can read design queue" on public.design_requests;
create policy "Public can read design queue" on public.design_requests for select to anon, authenticated using (true);
drop policy if exists "Only designer email can insert" on public.design_requests;
create policy "Only designer email can insert" on public.design_requests for insert to authenticated with check (lower(auth.jwt()->>'email')='qq774658845@gmail.com');
drop policy if exists "Only designer email can update" on public.design_requests;
create policy "Only designer email can update" on public.design_requests for update to authenticated using (lower(auth.jwt()->>'email')='qq774658845@gmail.com') with check (lower(auth.jwt()->>'email')='qq774658845@gmail.com');
drop policy if exists "Only designer email can delete" on public.design_requests;
create policy "Only designer email can delete" on public.design_requests for delete to authenticated using (lower(auth.jwt()->>'email')='qq774658845@gmail.com');
insert into public.design_requests(id,queue_order,owner,task,category,status,submitted_date,note) values
(25,1,'小林','活动主视觉','活动海报','制作中','2026-10-19','首页活动主视觉，含横版和竖版。'),
(26,2,'小陈','新品产品详情页','详情页','排队中','2026-10-19','需要完整详情页长图。'),
(27,3,'小王','电商主图优化','电商主图','排队中','2026-10-19',''),
(28,4,'小周','社媒宣传海报','社媒素材','待反馈','2026-10-18','已发初稿，等待运营反馈。'),
(29,5,'小林','产品卖点长图','详情页','排队中','2026-10-18','')
on conflict(id) do nothing;
