class AddDemographicToAvatar < ActiveRecord::Migration[7.1]
  def change
    add_column :avatars, :information, :jsonb, default: {}

    add_column :avatars, :description_tmp, :jsonb, default: {}

    # Étape 2 : Copier les anciennes données (si elles existent et sont convertibles)
    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE avatars
          SET description_tmp = to_jsonb(description::text)
          WHERE description IS NOT NULL;
        SQL
      end
    end

    # Étape 3 : Supprimer l'ancienne colonne et renommer la nouvelle
    remove_column :avatars, :description
    rename_column :avatars, :description_tmp, :description
  end
end
