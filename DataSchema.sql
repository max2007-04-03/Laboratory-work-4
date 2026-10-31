CREATE TABLE users (
    user_id NUMBER,
    user_name VARCHAR(30) NOT NULL,
    user_email VARCHAR(50) NOT NULL,
    created_date TIMESTAMP NOT NULL,
    user_status VARCHAR(10) DEFAULT 'active' NOT NULL,
    CONSTRAINT users_pk PRIMARY KEY (user_id),
    CONSTRAINT users_name_chk CHECK (
        user_name REGEXP '^[A-Za-z0-9_]{3,30}$'
    ),
    CONSTRAINT users_email_chk CHECK (
        user_email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    ),
    CONSTRAINT users_status_chk CHECK (
        user_status IN ('active', 'inactive', 'blocked')
    )
);

CREATE TABLE players (
    user_id NUMBER,
    age_num NUMBER NOT NULL,
    weight_num FLOAT NOT NULL,
    coordination_status VARCHAR(20) DEFAULT 'Beginner' NOT NULL,
    CONSTRAINT players_pk PRIMARY KEY (user_id),
    CONSTRAINT players_user_fk FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT players_age_chk CHECK (
        age_num >= 5 AND age_num <= 100
    ),
    CONSTRAINT players_weight_chk CHECK (
        weight_num >= 20.0 AND weight_num <= 200.0
    ),
    CONSTRAINT players_coord_chk CHECK (
        coordination_status IN ('Beginner', 'Intermediate', 'Advanced')
    )
);

CREATE TABLE balance_boards (
    board_id NUMBER,
    platform_name VARCHAR(10) NOT NULL,
    material_name VARCHAR(30) NOT NULL,
    max_tilt_num FLOAT NOT NULL,
    CONSTRAINT balance_boards_pk PRIMARY KEY (board_id),
    CONSTRAINT balance_boards_platform_chk CHECK (
        platform_name IN ('Left', 'Right')
    ),
    CONSTRAINT balance_boards_tilt_chk CHECK (
        max_tilt_num >= 10.0 AND max_tilt_num <= 45.0
    )
);

CREATE TABLE sensors (
    sensor_id NUMBER,
    board_id NUMBER NOT NULL,
    sensor_type_name VARCHAR(30) NOT NULL,
    model_name VARCHAR(50) NOT NULL,
    sampling_rate_num NUMBER NOT NULL,
    sensitivity_num FLOAT NOT NULL,
    CONSTRAINT sensors_pk PRIMARY KEY (sensor_id),
    CONSTRAINT sensors_board_fk
    FOREIGN KEY (board_id) REFERENCES balance_boards (board_id),
    CONSTRAINT sensors_type_chk CHECK (
        sensor_type_name IN ('Accelerometer', 'Gyroscope', 'AG-Sensor')
    ),
    CONSTRAINT sensors_rate_chk CHECK (
        sampling_rate_num >= 10 AND sampling_rate_num <= 200
    ),
    CONSTRAINT sensors_sens_chk CHECK (
        sensitivity_num > 0.0
    )
);

CREATE TABLE calibrations (
    calibration_id NUMBER,
    user_id NUMBER NOT NULL,
    sensor_id NUMBER NOT NULL,
    calibration_date TIMESTAMP NOT NULL,
    offset_x_num FLOAT NOT NULL,
    offset_y_num FLOAT NOT NULL,
    calibration_status VARCHAR(20) DEFAULT 'Success' NOT NULL,
    CONSTRAINT calibrations_pk PRIMARY KEY (calibration_id),
    CONSTRAINT calibrations_user_fk
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT calibrations_sensor_fk
    FOREIGN KEY (sensor_id) REFERENCES sensors (sensor_id),
    CONSTRAINT calibrations_status_chk CHECK (
        calibration_status IN ('Success', 'Failed', 'In_Progress')
    )
);

CREATE TABLE game_characters (
    character_id NUMBER,
    character_name VARCHAR(30) NOT NULL,
    speed_num FLOAT NOT NULL,
    character_status VARCHAR(20) DEFAULT 'Active' NOT NULL,
    CONSTRAINT game_characters_pk PRIMARY KEY (character_id),
    CONSTRAINT game_characters_name_chk CHECK (
        character_name REGEXP '^[A-Za-z0-9 _-]{2,30}$'
    ),
    CONSTRAINT game_characters_speed_chk CHECK (
        speed_num >= 0.0 AND speed_num <= 50.0
    ),
    CONSTRAINT game_characters_status_chk CHECK (
        character_status IN ('Active', 'Inactive', 'Locked')
    )
);

CREATE TABLE training_sessions (
    session_id NUMBER,
    user_id NUMBER NOT NULL,
    sensor_id NUMBER NOT NULL,
    character_id NUMBER NOT NULL,
    session_date TIMESTAMP NOT NULL,
    duration_num NUMBER NOT NULL,
    score_total NUMBER DEFAULT 0 NOT NULL,
    session_status VARCHAR(20) DEFAULT 'Completed' NOT NULL,
    CONSTRAINT training_sessions_pk PRIMARY KEY (session_id),
    CONSTRAINT training_sessions_user_fk
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT training_sessions_sensor_fk
    FOREIGN KEY (sensor_id) REFERENCES sensors (sensor_id),
    CONSTRAINT training_sessions_char_fk
    FOREIGN KEY (character_id) REFERENCES game_characters (character_id),
    CONSTRAINT training_sessions_dur_chk CHECK (
        duration_num >= 10 AND duration_num <= 3600
    ),
    CONSTRAINT training_sessions_score_chk CHECK (
        score_total >= 0
    ),
    CONSTRAINT training_sessions_status_chk CHECK (
        session_status IN ('Completed', 'Aborted', 'Running')
    )
);
