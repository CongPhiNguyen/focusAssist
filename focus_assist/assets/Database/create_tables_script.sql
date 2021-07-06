--
-- File generated with SQLiteStudio v3.3.2 on Mon May 17 17:07:08 2021
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: LICHSUTIMER
CREATE TABLE LICHSUTIMER (
    MANGUOIDUNG TEXT,
    THOIGIAN DATETIME,
    KHOANGTHOIGIAN TIME,
    DAHOANTHANH BOOL,
    PRIMARY KEY (MANGUOIDUNG, THOIGIAN)
);

-- Table: MUCTIEU
CREATE TABLE MUCTIEU (
    MAMUCTIEU TEXT PRIMARY KEY,
    MANGUOIDUNG TEXT,
    MANHOM TEXT,
    TENMUCTIEU TEXT,
    MOTA TEXT,
    NGAYBATDAU INTEGER,
    LOAIHINH TEXT,
    CACNGAY INTEGER,
    SOLAN INTEGER,
    KHOANGTHOIGIAN INTEGER
);

-- Table: NGUOIDUNG
CREATE TABLE NGUOIDUNG (
    MANGUOIDUNG TEXT PRIMARY KEY,
    TENTAIKHOAN TEXT,
    MATKHAU TEXT
);

-- Table: NHOMMUCTIEU
CREATE TABLE NHOMMUCTIEU (
    MANHOM TEXT PRIMARY KEY,
    MANGUOIDUNG TEXT,
    TENNHOM TEXT
);

-- Table: THANHTUU
CREATE TABLE THANHTUU (
    MATHANHTUU TEXT PRIMARY KEY,
    TENTHANHTUU TEXT,
    MOTA TEXT,
    CAPDO INTEGER,
    VANG INTEGER
);

-- Table: THANHTUUNGUOIDUNG
CREATE TABLE THANHTUUNGUOIDUNG (
    MATHANHTUU TEXT,
    MANGUOIDUNG TEXT,
    PRIMARY KEY (MATHANHTUU, MANGUOIDUNG)
);

-- Table: THONGKE
CREATE TABLE THONGKE (
    MAMUCTIEU TEXT,
    NGAYHOANTHANH INTEGER,
    PRIMARY KEY (MAMUCTIEU, NGAYHOANTHANH)
);

-- Table: THONGTINNGUOIDUNG
CREATE TABLE THONGTINNGUOIDUNG (
    MANGUOIDUNG TEXT PRIMARY KEY,
    HOTEN TEXT,
    ANH BLOB,
    VANG INTEGER,
    THONGBAO BOOL,
    THONGBAOSANG BOOL,
    THONGBAOTOI BOOL,
    THOIGIANTHONGBAOSANG TIME,
    THOIGIANTHONGBAOTOI TIME,
    DARKMODE BOOL,
    PRIVACYLOCK BOOL,
    LOCKPASSCODE TEXT,
    FIRSTPETNAME TEXT,
    CHILDHOODNAME TEXT
);

-- Table: TRICHDAN
CREATE TABLE TRICHDAN (
    MATRICHDAN TEXT PRIMARY KEY,
    TRICHDAN TEXT,
    TACGIA TEXT
);

-- Table: VATPHAM
CREATE TABLE VATPHAM (
    MAVATPHAM TEXT PRIMARY KEY,
    TENVATPHAM TEXT,
    MOTA TEXT,
    GIA INTEGER,
    DOHIEM INTEGER
);

-- Table: POKEMON
CREATE TABLE POKEMON (
    MAPOKEMON TEXT PRIMARY KEY,
    NAMEPOKEMON TEXT,
    MANGUOIDUNG TEXT,
    LEVELPOKEMON INTEGER,
    DOHIEM INTEGER
);


-- Table: VATPHAMNGUOIDUNG
CREATE TABLE VATPHAMNGUOIDUNG (
    MAVATPHAM TEXT,
    MANGUOIDUNG TEXT,
    PRIMARY KEY (MAVATPHAM, MANGUOIDUNG)
);

-- Table: THAMSO
CREATE TABLE THAMSO (
    DADANGNHAP BOOL,
    MANGUOIDUNG TEXT,
    PRIMARY KEY (DADANGNHAP, MANGUOIDUNG)
);

INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP01', 'Carpentry', '?', 100, 1);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP02', 'Electric', '?', 200, 2);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP03', 'Fire', '?', 350, 3);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP04', 'Ice',  '?', 200, 2);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP05', 'Magic', '?', 100, 1);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP06', 'Rock', '?', 200, 2);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP07', 'Sky', '?', 350, 3);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP08', 'Water', '?', 350, 3);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP09', 'Blue', '?', 500, 4);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP10', 'Cheese', '?', 500, 4);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP11', 'Chocolate', '?', 500, 4);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP12', 'Cream', '?', 100, 1);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP13', 'DeepBlue',  '?', 100, 1);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP14', 'Demon', '?', 200, 2);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP15', 'Diamod', '?', 350, 3);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP16', 'Forest', '?', 500, 4);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP17', 'Loli', '?', 100, 1);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP18', 'Silver',  '?', 200, 2);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP19', 'Strawberry', '?', 350, 3);
INSERT INTO VATPHAM (MAVATPHAM,TENVATPHAM,MOTA,GIA,DOHIEM) VALUES ('VP20', 'Sweety',  '?', 500, 4);


INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT01', 'Blue', 'Trứng Blue', 1, 25);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT02', 'Carpentry', 'Trứng Carpentry', 1, 35);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT03', 'Cheese', 'Trứng Cheese', 1, 45);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT04', 'Chocolate', 'Trứng Chocolate', 1, 55);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT05', 'Cream', 'Trứng Cream', 1, 25);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT06', 'DeepBlue', 'Trứng DeepBlue', 1, 35);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT07', 'Demon', 'Trứng Demon', 1, 45);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT08', 'Diamod', 'Trứng Diamod', 1, 55);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT09', 'Electric', 'Trứng Electric', 1, 25);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT10', 'Fire', 'Trứng Fire', 1, 35);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT11', 'Forest', 'Trứng Forest', 1, 45);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT12', 'Ice', 'Trứng Ice', 1, 55);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT13', 'Loli', 'Trứng Loli', 1, 25);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT14', 'Magic', 'Trứng Magic', 1, 35);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT15', 'Rock', 'Trứng Rock', 1, 45);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT16', 'Silver', 'Trứng Silver', 1, 55);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT17', 'Sky', 'Trứng Sky',1,25);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT18', 'Strawberry', 'Trứng Strawberry', 1, 35);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT19', 'Sweety', 'Trứng Sweety', 1, 45);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT20', 'Water', 'Trứng Water', 1, 55);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT21', 'Blue 2', 'Blue level 25', 2, 120);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT22', 'Carpentry 2', 'Carpentry level 25', 2, 140);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT23', 'Cheese 2', 'Cheese level 25', 2, 160);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT24', 'Chocolate 2', 'Chocolate level 25', 2, 180);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT25', 'Cream 2', 'Cream level 25', 2, 120);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT26', 'DeepBlue 2', 'DeepBlue level 25', 2, 140);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT27', 'Demon 2', 'Demon level 25', 2, 160);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT28', 'Diamod 2', 'Diamod level 25', 2, 180);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT29', 'Electric 2', 'Electric level 25', 2, 120);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT30', 'Fire 2', 'Fire level 25', 2, 140);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT31', 'Forest 2', 'Forest level 25', 2, 160);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT32', 'Ice 2', 'Ice level 25', 2, 180);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT33', 'Loli 2', 'Loli level 25', 2, 120);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT34', 'Magic 2', 'Magic level 25', 2, 140);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT35', 'Rock 2', 'Rock level 25', 2, 120);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT36', 'Silver 2', 'Silver level 25', 2, 180);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT37', 'Sky 2', 'Sky level 25',2,120);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT38', 'Strawberry 2', 'Strawberry level 25', 2, 140);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT39', 'Sweety 2', 'Sweety level 25',2, 160);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT40', 'Water 2', 'Water level 25', 2, 180);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT41', 'Blue 3', 'Blue level 50', 3, 350);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT42', 'Carpentry 3', 'Carpentry level 50', 3, 450);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT43', 'Cheese 3', 'Cheese level 50', 3, 550);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT44', 'Chocolate 3', 'Chocolate level 50', 3, 650);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT45', 'Cream 3', 'Cream level 50', 3, 350);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT46', 'DeepBlue 3', 'DeepBlue level 50', 3, 450);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT47', 'Demon 3', 'Demon level 50', 3, 550);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT48', 'Diamod 3', 'Diamod level 50',3, 650);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT49', 'Electric 3', 'Electric level 50', 3, 350);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT50', 'Fire 3', 'Fire level 50', 3, 450);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT51', 'Forest 3', 'Forest level 50', 3, 550);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT52', 'Ice 3', 'Ice level 50', 3, 650);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT53', 'Loli 3', 'Loli level 50', 3, 350);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT54', 'Magic 3', 'Magic level 50', 3, 450);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT55', 'Rock 3', 'Rock level 50', 3, 550);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT56', 'Silver 3', 'Silver level 50', 3, 650);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT57', 'Sky 3', 'Sky level 50',3,330);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT58', 'Strawberry 3', 'Strawberry level 50', 3, 450);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT59', 'Sweety 3', 'Sweety level 50',3, 550);
INSERT INTO THANHTUU (MATHANHTUU,TENTHANHTUU,MOTA,CAPDO,VANG) VALUES ('TT60', 'Water 3', 'Water level 50', 3, 650);

INSERT INTO THAMSO (DADANGNHAP, MANGUOIDUNG) VALUES (0, '');

INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD00',"You are never too old to set another goal, to dream a new dream",'C. S. Lewis');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD01',"Either I will find a way, or I will make one",'Philip Sidney');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD02',"Motivation is what gets you started. Habit is what keeps you going",'Jim Ryun');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD03',"Our greatest weakness lies is giving up. The most certain way to succeed is always to try just one more time",'Thomas A. Edison');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD04',"Always do your best. What you plant now, you will harvest later",'Og Mandino');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD05',"The will to win, the desire to succeed, the urge to reach your full potential... these are the keys that will unlock the door to personal excellence",'Confucius');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD06',"Keep your eyes on the stars, and your feet on the ground",'Theodore Roosevelt');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD07',"You have to learn the rules of the game. And then you have to play better than anyone else",'Albert Einstein');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD08',"Don't watch the clock, do what it does. Keep going",'Sam Levenson');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD09',"I can't change the direction of the wind, but I can adjust my sails to always reach my destination",'Jimmy Dean');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD10',"Nothing is impossible, the world itself says I'm possible!",'Audrey Hepburn');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD11',"As we express our gratitude, we must never forget that the highest appreciation is not to utter words, but to live by them",'John F. Kennedy');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD12',"The measure of who we are is what we do with what we have",'Vince Lombardi');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD13',"Put your heart, mind, and soul into even your smallest acts. This is the secret of success",'Swami Sivananda');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD14',"I dwell in possibility",'Emily Dickinson');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD15',"Keep your face to the sunshine and you cannot see a shadow",'Helen Keller');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD16',"Believe that life is worth living and your belief will help create the fact",'William James');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD17',"Yesterday is not ours to recover, but tomorrow is ours to win or lose",'Lyndon B. Johnson');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD18',"When you wake up every day, you have two choices. You can either be positive or negative, an optimist or a pessimist. I choose to be an optimist. It's all a matter of perspective",'Harvey Mackay');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD19',"You're going to go through tough times - that's life. But I say, 'Nothing happens to you, it happens for you.' See the positive in negative events",'Joel Osteen');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD20',"To be beautiful means to be yourself. You don't need to be accepted by others. You need to be yourself",'Thich Nhat Hanh');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD21',"No matter how you feel, get up, dress up, show up and never give up",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD22',"Believe you can and you're halfway there",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD23',"If you can imagine it, you can archive it. If you can dream it, you can become it",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD24',"When you feel like quitting, think about why you started",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD25',"Lose an hour in the morning, and you will be all day hunting for it",'Richard Whately');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD26',"I never knew a man who come to greatness or eminence who lay abed late in the morning",'Johnathan Swift');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD27',"You don't have to be great to start. But you do have to start to be great",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD28',"If you don't build your dream, someone will hire you to help build theirs",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD29',"You may delay, but time will not",'Benjamin Franklin');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD30',"Your life does not get better by chance, it gets better by change",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD31',"Be the change you need to see in the world",'Mahatma Gandhi');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD32',"If you can dream it, you can do it",'Walt Disney');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD33',"Start where you are. Use what you have. Do what you can",'Theodore Roosevelt');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD34',"Set your goals high, and don't stop till you get there",'Bo Jackson');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD35',"You can never quit. Winners never quit, and quitters never win",'Ted Turner');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD36',"To begin, begin",'William Wordsworth');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD37',"Only I can change my life. No one can do it for me",'Carol Burnett');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD38',"Live as if you were to die tomorrow. Learn as if you were to live forever",'Mahatma Gandhi');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD39',"Don't let the fear of losing be greater than the excitement of winning",'Robert Kiyosaki');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD40',"Never put off till tomorrow that you can do today",'Thomas Jefferson');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD41',"Stay hungry, stay foolish",'Steve Jobs');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD42',"Do it now. Sometimes 'later' becomes 'never'",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD43',"Do it badly, do it slowly, do it fearfully, do it any way you have to, but do it",'Steve Chandler');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD44',"If today were the last day of your life, would you want to do what you are about to do today?",'Steve Jobs');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD45',"When you fail to plan, you plan to fail",'Benjamin Franklin');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD46',"Successful people are not gifted, they just work hard, then succeed on purpose",'G.K.Nielson');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD47',"Ask yourself if what you're doing today is getting you closer to where you want to be tomorrow",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD48',"Push today for what you want tomorrow",'Lori Myers');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD49',"Wake up early and tackle the day before it tackles you. Be on offense, not defense",'Evan Carmichael');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD50',"Dream is not what you see in sleep, dream is something which doesn't let you sleep",'A.P.J.Abdul Kalam');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD51',"I hated every minute of training, but I said, dont's quit. Suffer now and live rest of your life as a champion",'Muhammad Ali');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD52',"You can have anything you want if you are willing to give up the belief that you can't have it",'Robert Anthony');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD53',"It's not about time, it's about choices. How are you spending your choices?",'Beverly Adamo');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD54',"Success seems to be connected with action. Successful people keep moving. They make mistakes, but they don't quit",'Conrad Hilton');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD55',"Even the smallest of thoughts have the potential to become the biggest of successes, all you have to do is get up and get going",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD56',"That's precisely the question everyone should be asking, why the hell not? Why not you? Why not now?",'Timothy Ferriss');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD57',"Try not to become a man of success but rather try to become a man of value",'Albert Einstein');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD58',"If yesterday was an amazing day for you, don't stop. Maybe your winning streak has just begun",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD59',"Wake up and face life's chanllenges head on. Else, life will become quite a challenge",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD60',"Why complain about yesterday, when you can make a better tommorrow by making the most of today?",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD61',"Every great story on the planet happened when someone decided not to give up, but kept going no matter what",'Spryte Loriano');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD62',"If you haven't been able to archieve something, today is the best time to start working towards it again",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD63',"You were born to be a player. You were meant to be here. This moment is yours",'Herb Brooks');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD64',"It is not just another day, it is yet another chance to make your dreams come true",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD65',"Dude, suckin' at something is the first step to being sorta good at something",'Jake, Adventure Time');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD66',"It's your road, and yours alone. Others may walk it with you but no one can walk it for you",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD67',"Work until your idols become your rivals",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD68',"Success isn't about being the best. It's about always getting better",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD69',"Doubts kill more dream than failure ever will",'Karim Seddiki');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD70',"The journey of a thousand miles begins with a single step",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD71',"It is more important to know where you are going than to get there quickly. Do not mistake activity for archievement",'Isocrates');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD72',"Courage doesn't always roar, sometime it's the quiet voice at the end of the day whispering 'I will try again tommorrow'",'MaryAnn Rademacher');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD73',"You can feel sore tomorrow or you can feel sorry tomorrow. You choose",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD74',"If you fear failure, you will never go anywhere",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD75',"Darkness cannot drive out darkness, only light can do that. Hate cannot drive out hate, only love can do that",'Martin Luther King JR');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD76',"The journey is the reward",'Steve Jobs');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD77',"Happiness is not the absence of problems, it's the ability to deal with them",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD78',"It is never too late to be what you might have been",'George Eliot');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD79',"Make sure your worst enemy doesn't live between your two ears",'Laird Hamilton');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD80',"What you do today is important because you are exchanging a day of your life for it",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD81',"Life begins at the end of your comfort zone",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD82',"Always be yourself, express yourself, have faith in yourself. Do not go out and look for a successful personality and duplicate it",'Bruce Lee');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD83',"Today I will do what other's won't, so tomorrow I will do what others can't",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD84',"It is not the load that breaks you down, it's the way you carry it",'Lou Holtz');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD85',"Adventure may hurt you, but monotony will kill you",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD86',"Imagination is more important than knowledge. Knowledge is limited. Imagination encircles the world",'Albert Einstein');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD87',"It always seem impossible until it's done",'Nelson Mandela');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD88',"One day you will wake up and there won't be any more time to do the things you've always wanted. Do it now",'Paulo Coelho');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD89',"You may not control all the events that happen to you, but you can decide not to be reduced by them",'Maya Angelou');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD90',"It is possible to commit no mistakes and still lose. That is not a weakness, that is life",'Jean Luc Picard');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD91',"children are wonderfully confident in their imaginations. Most of us lose this confidence as we grow up",'Sir Ken Robinson');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD92',"You can't climb the ladder of success with your hands in your pockets",'Arnold Schwarzenegger');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD93',"If you spend too much time thinking about a thing, you'll never get it done",'Bruce Lee');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD94',"Winning starts with beginning",'Anonymous');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD95',"Never give up a dream just because of the time it will take to accomplish it.The time will pass anyway",'Earl Nightingale');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD96',"Life is too short, she panicked, 'I want more'. He nodded slowly, 'Wake up ealier'",'Dr. Sunwolf');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD97',"So many of our dreams at first seem impossible. Then thay seem improbable. And then, when we summon the will, they soon become inevitalbe",'Nelson Mandela');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD98',"Do more of what makes you happy",'Carmel McConnell');
INSERT INTO TRICHDAN(MATRICHDAN, TRICHDAN, TACGIA) VALUES ('TD99',"While we are postponing, life speeds up",'Seneca');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;