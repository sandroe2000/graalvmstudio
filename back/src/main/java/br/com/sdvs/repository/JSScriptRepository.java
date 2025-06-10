package br.com.sdvs.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import br.com.sdvs.model.JSScript;

@Repository
public interface JSScriptRepository extends JpaRepository<JSScript, Long> {
    Optional<JSScript> findByLocationAndName(String location, String name);
}
