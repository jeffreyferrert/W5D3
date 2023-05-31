PRAGMA foreign_keys = ON;

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    question_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT,
    author_id INTEGER,

    FOREIGN KEY (author_id) REFERENCES users(user_id)
);

CREATE TABLE question_follows (
    user_id INTEGER,
    question_id INTEGER,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

CREATE TABLE replies (
    reply_id INTEGER PRIMARY KEY,
    subject_question_id INTEGER,
    parent_reply_id INTEGER,
    user_id INTEGER,
    body TEXT,

    FOREIGN KEY (subject_question_id) REFERENCES questions(question_id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(reply_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE question_likes (
    user_id INTEGER,
    question_id INTEGER,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('michelle', 'li'),
    ('jeffrey', 'ferrer');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ("What is 2 + 2?", "I hate math", (SELECT user_id FROM users WHERE fname = "michelle")),

    ("What is the best city in the world?", "not new york :(", (SELECT user_id FROM users WHERE fname = "jeffrey"));





