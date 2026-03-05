BEGIN;

-- =====================================================
-- (OPTIONNEL MAIS RECOMMANDÉ) : rendre les jointures idempotentes
-- =====================================================
ALTER TABLE IF EXISTS book_authors
  ADD CONSTRAINT IF NOT EXISTS uq_book_authors UNIQUE (book_isbn, authors_id);

ALTER TABLE IF EXISTS book_subjects
  ADD CONSTRAINT IF NOT EXISTS uq_book_subjects UNIQUE (book_isbn, subjects_id);

ALTER TABLE IF EXISTS roles_privileges
  ADD CONSTRAINT IF NOT EXISTS uq_roles_privileges UNIQUE (role_id, privilege_id);

ALTER TABLE IF EXISTS users_roles
  ADD CONSTRAINT IF NOT EXISTS uq_users_roles UNIQUE (user_id, role_id);

ALTER TABLE IF EXISTS user_owned_books
  ADD CONSTRAINT IF NOT EXISTS uq_user_owned_books UNIQUE (user_id, book_isbn);


-- ============================
-- SUBJECTS
-- ============================
INSERT INTO subjects (name) VALUES ('Fantasy')
ON CONFLICT (name) DO NOTHING;

INSERT INTO subjects (name) VALUES ('Science Fiction')
ON CONFLICT (name) DO NOTHING;

INSERT INTO subjects (name) VALUES ('Romance')
ON CONFLICT (name) DO NOTHING;


-- ============================
-- AUTHORS
-- (si tu as un unique sur (first_name,last_name) c'est parfait.
-- sinon, ça va insérer des doublons si tu relances)
-- ============================
-- Option A (recommandé): si tu as (ou ajoutes) un unique :
-- ALTER TABLE authors ADD CONSTRAINT uq_authors_name UNIQUE (first_name, last_name);

INSERT INTO authors (first_name, last_name, user_id)
VALUES ('Sarah', 'Brennan', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO authors (first_name, last_name, user_id)
VALUES ('Mackenzi', 'Lee', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO authors (first_name, last_name, user_id)
VALUES ('Mark', 'Oshiro', NULL)
ON CONFLICT DO NOTHING;


-- ============================
-- IMAGES
-- (idem: idéalement url unique)
-- ============================
-- Option A (recommandé): ALTER TABLE image ADD CONSTRAINT uq_image_url UNIQUE (url);

INSERT INTO image (url)
VALUES ('https://ia600100.us.archive.org/view_archive.php?archive=/5/items/l_covers_0012/l_covers_0012_35.zip&file=0012354250-L.jpg')
ON CONFLICT DO NOTHING;

INSERT INTO image (url)
VALUES ('https://ia601705.us.archive.org/view_archive.php?archive=/29/items/l_covers_0008/l_covers_0008_36.zip&file=0008367802-L.jpg')
ON CONFLICT DO NOTHING;

INSERT INTO image (url)
VALUES ('https://ia800100.us.archive.org/view_archive.php?archive=/5/items/l_covers_0012/l_covers_0012_36.zip&file=0012366752-L.jpg')
ON CONFLICT DO NOTHING;


-- ============================
-- BOOK
-- ============================
INSERT INTO book (isbn, title, publishing_year, description, pages, image_id)
VALUES (
  '9781250167026',
  'Anger is a Gift',
  2018,
  '**MOSS JEFFRIES** is many things--considerate student, devoted son, loyal friend and affectionate boyfriend, enthusiastic nerd.

But sometimes Moss still wishes he could be someone else--someone without panic attacks, someone whose father was still alive, someone who hadn''t become a rallying point for a community because of one horrible night.

And most of all, he wishes he didn''t feel so stuck.

Moss can''t even escape at school--he and his friends are subject to the lack of funds and crumbling infrastructure at West Oakland High, as well as constant intimidation by the resource officer stationed in their halls. It feels sometimes that the students are treated more like criminals.

Something needs to change--but who will listen to a group of teens?

When tensions hit a fever pitch and tragedy strikes again, Moss must face a difficult choice: give in to fear and hate or realize that anger can actually be a gift.

This description comes from the publisher.',
  463,
  3
)
ON CONFLICT (isbn) DO UPDATE SET
  title = EXCLUDED.title,
  publishing_year = EXCLUDED.publishing_year,
  description = EXCLUDED.description,
  pages = EXCLUDED.pages,
  image_id = EXCLUDED.image_id;

INSERT INTO book (isbn, title, publishing_year, description, pages, image_id)
VALUES (
  '9789877473216',
  'The Gentleman''s Guide to Vice and Virtue',
  2017,
  'Henry "Monty" Montague was born and bred to be a gentleman, but he was never one to be tamed. The finest boarding schools in England and the constant disapproval of his father haven''t been able to curb any of his roguish passions--not for gambling halls, late nights spent with a bottle of spirits, or waking up in the arms of women or men.

But as Monty embarks on his Grand Tour of Europe, his quest for a life filled with pleasure and vice is in danger of coming to an end. Not only does his father expect him to take over the family''s estate upon his return, but Monty is also nursing an impossible crush on his best friend and traveling companion, Percy.

Still, it isn''t in Monty''s nature to give up. Even with his younger sister, Felicity, in tow, he vows to make this yearlong escapade one last hedonistic hurrah and flirt with Percy from Paris to Rome. But when one of Monty''s reckless decisions turns their trip abroad into a harrowing manhunt that spans across Europe, it calls into question everything he knows, including his relationship with the boy he adores.',
  445,
  2
)
ON CONFLICT (isbn) DO UPDATE SET
  title = EXCLUDED.title,
  publishing_year = EXCLUDED.publishing_year,
  description = EXCLUDED.description,
  pages = EXCLUDED.pages,
  image_id = EXCLUDED.image_id;

INSERT INTO book (isbn, title, publishing_year, description, pages, image_id)
VALUES (
  '9781618731203',
  'In Other Lands',
  2017,
  'The Borderlands aren’’t like anywhere else. Don’’t try to smuggle a phone or any other piece of technology over the wall that marks the Border — unless you enjoy a fireworks display in your backpack. (Ballpoint pens are okay.) There are elves, harpies, and — best of all as far as Elliot is concerned — mermaids.

"What’’s your name?"

"Serene."

"Serena?" Elliot asked.

"Serene," said Serene. "My full name is Serene-Heart-in-the-Chaos-of-Battle."

Elliot’’s mouth fell open. "That is badass."

Elliot? Who’’s Elliot? Elliot is thirteen years old. He’’s smart and just a tiny bit obnoxious. Sometimes more than a tiny bit. When his class goes on a field trip and he can see a wall that no one else can see, he is given the chance to go to school in the Borderlands.

It turns out that on the other side of the wall, classes involve a lot more weaponry and fitness training and fewer mermaids than he expected. On the other hand, there’’s Serene-Heart-in-the-Chaos-of-Battle, an elven warrior who is more beautiful than anyone Elliot has ever seen, and then there’’s her human friend Luke: sunny, blond, and annoyingly likeable. There are lots of interesting books. There’’s even the chance Elliot might be able to change the world.',
  437,
  1
)
ON CONFLICT (isbn) DO UPDATE SET
  title = EXCLUDED.title,
  publishing_year = EXCLUDED.publishing_year,
  description = EXCLUDED.description,
  pages = EXCLUDED.pages,
  image_id = EXCLUDED.image_id;


-- ============================
-- BOOK ↔ AUTHORS LINK
-- ============================
INSERT INTO book_authors (book_isbn, authors_id)
VALUES ('9781618731203', 1)
ON CONFLICT DO NOTHING;

INSERT INTO book_authors (book_isbn, authors_id)
VALUES ('9789877473216', 2)
ON CONFLICT DO NOTHING;

INSERT INTO book_authors (book_isbn, authors_id)
VALUES ('9781250167026', 3)
ON CONFLICT DO NOTHING;


-- ============================
-- BOOK ↔ SUBJECTS LINK
-- ============================
INSERT INTO book_subjects (book_isbn, subjects_id)
VALUES ('9781618731203', 1)
ON CONFLICT DO NOTHING;

INSERT INTO book_subjects (book_isbn, subjects_id)
VALUES ('9789877473216', 1)
ON CONFLICT DO NOTHING;

INSERT INTO book_subjects (book_isbn, subjects_id)
VALUES ('9781250167026', 1)
ON CONFLICT DO NOTHING;


-- =====================================================
-- ROLES
-- =====================================================
INSERT INTO role (id, name) VALUES (1, 'USER')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO role (id, name) VALUES (2, 'AUTHOR')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO role (id, name) VALUES (3, 'LIBRARIAN')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO role (id, name) VALUES (4, 'SELLER')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO role (id, name) VALUES (5, 'ADMIN')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;


-- =====================================================
-- PRIVILEGES
-- =====================================================
INSERT INTO privilege (id, name) VALUES (1, 'BOOK_VIEW')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (2, 'AUTHOR_VIEW')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (10, 'LIBRARY_MANAGE')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (11, 'READING_TRACK')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (20, 'REVIEW_WRITE')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (21, 'SOCIAL_INTERACT')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (22, 'GROUP_MANAGE')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (30, 'SELLER_VIEW')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (100, 'BOOK_PUBLISH')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (101, 'AUTHOR_CONTENT_MANAGE')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (102, 'AUTHOR_ANALYTICS')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (200, 'BOOK_EDIT')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (201, 'CONTENT_MODERATE')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

INSERT INTO privilege (id, name) VALUES (300, 'INVENTORY_MANAGE')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;


-- =====================================================
-- ROLE → PRIVILEGE ASSIGNMENTS
-- =====================================================
INSERT INTO roles_privileges (role_id, privilege_id) VALUES
  (1, 1), (1, 2),
  (1, 10), (1, 11),
  (1, 20), (1, 21), (1, 22),
  (1, 30)
ON CONFLICT DO NOTHING;

INSERT INTO roles_privileges (role_id, privilege_id) VALUES
  (2, 1), (2, 2), (2, 10), (2, 11),
  (2, 20), (2, 21), (2, 22), (2, 30),
  (2, 100), (2, 101), (2, 102)
ON CONFLICT DO NOTHING;

INSERT INTO roles_privileges (role_id, privilege_id) VALUES
  (3, 1), (3, 2), (3, 10), (3, 11),
  (3, 20), (3, 21), (3, 22), (3, 30),
  (3, 200), (3, 201)
ON CONFLICT DO NOTHING;

INSERT INTO roles_privileges (role_id, privilege_id) VALUES
  (4, 1), (4, 2), (4, 10), (4, 11),
  (4, 30), (4, 300)
ON CONFLICT DO NOTHING;

INSERT INTO roles_privileges (role_id, privilege_id)
SELECT 5, id FROM privilege
ON CONFLICT DO NOTHING;


-- ============================
-- USER DE DEMO
-- ============================
INSERT INTO users (id, first_name, last_name, email, password, google_id, picture)
VALUES (100, 'Demo', 'User', 'demo@booksta.local', 'password', NULL, NULL)
ON CONFLICT (id) DO NOTHING;

-- Donne-lui le rôle USER
INSERT INTO users_roles (user_id, role_id)
VALUES (100, 1)
ON CONFLICT DO NOTHING;

-- Recaler la séquence (plus robuste)
-- (remplace 'user_sequence' par le nom exact si différent)
SELECT setval('user_sequence', (SELECT COALESCE(MAX(id), 0) FROM users) + 1, false);


-- ============================
-- LIVRES POSSEDES PAR LE USER 100
-- ============================
INSERT INTO user_owned_books (user_id, book_isbn)
VALUES (100, '9781250167026')
ON CONFLICT DO NOTHING;

INSERT INTO user_owned_books (user_id, book_isbn)
VALUES (100, '9789877473216')
ON CONFLICT DO NOTHING;

INSERT INTO user_owned_books (user_id, book_isbn)
VALUES (100, '9781618731203')
ON CONFLICT DO NOTHING;

COMMIT;