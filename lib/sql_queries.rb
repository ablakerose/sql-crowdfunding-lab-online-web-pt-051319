it '#selects_the_titles_of_all_projects_and_their_pledge_amounts_alphabetized_by_name' do
  expect(@db.execute(selects_the_titles_of_all_projects_and_their_pledge_amounts_alphabetized_by_name)).to eq([["Animal shelter needs dog food", 210], ["Help me buy a guitar", 98], ["Help save birds of paradise", 170], ["I have bed bugs!", 740], ["I want to teach English in China", 200], ["Iguana needs tail operation", 1035.5], ["My book on SQL", 20], ["The next Harry Potter", 120], ["The next Inna-Gadda-Davida", 342], ["Voldement needs a body", 489]])
end

it '#selects_the_user_name_age_and_pledge_amount_for_all_pledges_alphabetized_by_name' do
  expect(@db.execute(selects_the_user_name_age_and_pledge_amount_for_all_pledges_alphabetized_by_name)).to eq([["Albus", 113, 470], ["Alex", 33, 20], ["Amanda", 24, 40], ["Bear", 6, 50], ["Ena", 24, 100], ["Finnebar", 17, 70], ["Franz", 100, 90], ["Hermione", 30, 50], ["Iguana", 4, 10], ["Katie", 24, 170], ["Marisa", 24, 24], ["Pacha", 5, 60], ["Rosey", 9, 50], ["Sirius", 36, 19], ["Sophie", 24, 60], ["Squid", 5, 270], ["Swizzle", 4, 12], ["Victoria", 23, 1700], ["Voldemort", 90, 34], ["Whale", 6, 125.5]])
end

it '#selects_the_titles_and_amount_over_goal_of_all_projects_that_have_met_their_funding_goal' do
  expect(@db.execute(selects_the_titles_and_amount_over_goal_of_all_projects_that_have_met_their_funding_goal)).to eq([["My book on SQL", 0], ["The next Inna-Gadda-Davida", 142]])
end

it '#selects_user_names_and_amounts_of_all_pledges_grouped_by_name_then_orders_them_by_the_amount_and_users_name' do
  expect(@db.execute(selects_user_names_and_amounts_of_all_pledges_grouped_by_name_then_orders_them_by_the_amount_and_users_name)).to eq([["Iguana", 10], ["Swizzle", 12], ["Sirius", 19], ["Alex", 20], ["Marisa", 24], ["Voldemort", 34], ["Amanda", 40], ["Bear", 50], ["Hermione", 50], ["Rosey", 50], ["Pacha", 60], ["Sophie", 60], ["Finnebar", 70], ["Franz", 90], ["Ena", 100], ["Whale", 125.5], ["Katie", 170], ["Squid", 270], ["Albus", 470], ["Victoria", 1700]])
end

it '#selects_the_category_names_and_pledge_amounts_of_all_pledges_in_the_music_category' do
  expect(@db.execute(selects_the_category_names_and_pledge_amounts_of_all_pledges_in_the_music_category)).to eq([["music", 40], ["music", 24], ["music", 34], ["music", 12], ["music", 40], ["music", 40], ["music", 20], ["music", 230]])
end

it '#selects_the_category_name_and_the_sum_total_of_the_all_its_pledges_for_the_books_category' do
  expect(@db.execute(selects_the_category_name_and_the_sum_total_of_the_all_its_pledges_for_the_books_category)).to eq([["books", 140]])
end
end
end

def selects_the_titles_of_all_projects_and_their_pledge_amounts_alphabetized_by_name
"SELECT projects.title, SUM(pledges.amount) FROM projects
    INNER JOIN pledges
      ON projects.id = pledges.project_id
    GROUP BY projects.title;"
end

def selects_the_user_name_age_and_pledge_amount_for_all_pledges_alphabetized_by_name
"SELECT users.name, users.age, SUM(pledges.amount) FROM users
    INNER JOIN pledges
      ON users.id = pledges.user_id
    GROUP BY users.name;"
end

def selects_the_titles_and_amount_over_goal_of_all_projects_that_have_met_their_funding_goal
"SELECT projects.title, (projects.funding_goal - SUM(pledges.amount)) * -1 AS over_goal FROM projects
    INNER JOIN pledges
      ON projects.id = pledges.project_id
    GROUP BY projects.title
    HAVING over_goal >= 0;"
end

def selects_user_names_and_amounts_of_all_pledges_grouped_by_name_then_orders_them_by_the_amount
"SELECT users.name, SUM(pledges.amount) AS total_pledges FROM users
    INNER JOIN pledges
      ON users.id = pledges.user_id
    GROUP BY users.name
    ORDER BY total_pledges;"
end

def selects_the_category_names_and_pledge_amounts_of_all_pledges_in_the_music_category
"SELECT projects.category, pledges.amount FROM projects
    INNER JOIN pledges
      ON projects.id = pledges.project_id
    WHERE category = 'music';"
end

def selects_the_category_name_and_the_sum_total_of_the_all_its_pledges_for_the_book_category
"SELECT projects.category, SUM(pledges.amount) AS total_pledges FROM projects
    INNER JOIN pledges
      ON projects.id = pledges.project_id
    WHERE category = 'books';"
end
